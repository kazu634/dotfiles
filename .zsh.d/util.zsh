: chpwd内のlsでファイル数が多い場合に省略表示する
: http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059 && {
  chpwd() {
      ls_abbrev
  }

  ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
      freebsd*|darwin*)
        if type gls > /dev/null 2>&1; then
          cmd_ls='gls'
        else
          # -G : Enable colorized output.
          opt_ls=('-aCFG')
        fi
        ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
      echo "$ls_result" | head -n 5
      echo '...'
      echo "$ls_result" | tail -n 5
      echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
      echo "$ls_result"
    fi
  }
}

: cdr + fzf setting && {
  : 前提条件 && {
    autoload -Uz add-zsh-hook
    autoload -Uz chpwd_recent_dirs cdr
    add-zsh-hook chpwd chpwd_recent_dirs
  }

  : cdr の設定 && {
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
  }

  : 関数の定義 && {
    if which fzf > /dev/null; then
      function fzf-cdr () {
          my-compact-chpwd-recent-dirs

          local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
          if [ -n "$selected_dir" ]; then
              BUFFER="cd ${selected_dir}"
              zle accept-line
          fi
          zle clear-screen
      }

      zle -N fzf-cdr
      bindkey '^x' fzf-cdr
    fi
  }

  : メンテナンス && {
    # http://blog.n-z.jp/blog/2014-07-25-compact-chpwd-recent-dirs.html
    function my-compact-chpwd-recent-dirs () {
      emulate -L zsh
      setopt extendedglob
      local -aU reply
      integer history_size
      autoload -Uz chpwd_recent_filehandler
      chpwd_recent_filehandler
      history_size=$#reply
      reply=(${^reply}(N))
      (( $history_size == $#reply )) || chpwd_recent_filehandler $reply
    }
  }
}

: history + fzf function && {
  # use `fzf` to see the history:
  if which peco > /dev/null; then
    # statements
    function fzf-select-history() {
      local tac

      if which tac > /dev/null; then
        tac="tac"
      else
        tac="tail -r"
      fi

      BUFFER=$(history -n 1 | \
        eval $tac | \
        awk '!a[$0]++' | \
        fzf --query "$LBUFFER")

      CURSOR=$#BUFFER
      zle clear-screen
    }

    zle -N fzf-select-history

    bindkey '^r' fzf-select-history
  fi
}
