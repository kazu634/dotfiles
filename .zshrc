# === Completition ===

# zsh-completions
case ${OSTYPE} in
  darwin*)
    # for mac
    fpath=(/usr/local/share/zsh-completions $fpath)
    ;;
esac

# General completion config
autoload -U compinit
compinit

setopt correct

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1 # 補完メニューをカーソルで選択可能にする。
zstyle ':completion:*:cd:*' tag-order local-directories path-directories # カレントに候補が無い場合のみcdpath 上のディレクトリが候補となる。
zstyle ':completion:*' use-cache true # 補完でキャッシュを有効にする
zstyle ':completion:*' list-colors di=33 fi=0 # 補完時のファイル名を黄色で表示

setopt list_packed # 補完候補をつめて表示する
setopt auto_menu # TAB で順に補完候補を切り替える
setopt auto_list # 複数の補完候補があったときに、そのリストを自動的に表示
setopt complete_in_word # 補完開始時にカーソルは単語の終端になくても良い。
setopt list_types # 種類を示すマーク表示をつける(ls -fと同じもの)
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える

# For git-completion
autoload bashcompinit
bashcompinit

case ${OSTYPE} in
  darwin*)
    # For Mac
    GIT_COMPLETION=`find /usr/local/Cellar/git/ -type f -name "git-completion.bash" | xargs ls -t | head -1`
    source ${GIT_COMPLETION}
    ;;

  linux*)
    # for Linux
    if [ -f ~/.git-completion.bash ]; then
      source ~/.git-completion.bash
    fi
    ;;

esac

# === Prediction ===
autoload predict-on
predict-on

# === History ===
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000

setopt hist_no_store hist_ignore_dups hist_reduce_blanks hist_ignore_space
setopt incappendhistory sharehistory
setopt extended_history
setopt hist_ignore_all_dups extended_history
setopt hist_save_no_dups

function history-all { history -E 1 }

# === Key Bind ===
bindkey -e

# === Color ===
autoload -U colors
colors

# === Prompt ===
if [ -n "$SSH_CONNECTION" ]; then
    PROMPT="%{$fg[blue]%}%n@%m%#%{$reset_color%} "
else
    PROMPT="%{$fg[green]%}%n@%m%#%{$reset_color%} "
fi

precmd () {
    if [ -n "$SSH_CONNECTION" ]; then
        PROMPT="%{%(?.$fg[blue].$fg[red])%}%n@%m%#%{$reset_color%} "
    else
        PROMPT="%{%(?.$fg[green].$fg[red])%}%n@%m%#%{$reset_color%} "
    fi
}


# RPROMPT settings
#
#  see: http://qiita.com/items/8d5a627d773758dd8078?utm_source=Qiita+Newsletter+Users&utm_campaign=7bd7dc59dd-Qiita_newsletter_32_26_12_2012&utm_medium=email

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr
# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


if is-at-least 4.3.10; then
    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
fi

# hooks 設定
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
                                            git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked フィアル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # master ブランチでない場合は何もしない
            return 0
        fi

        # push していないコミット数を取得する
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt [%~]"
}
add-zsh-hook precmd _update_vcs_info_msg


# === Direcotry ===
setopt auto_pushd
setopt PUSHD_IGNORE_DUPS

# === Aliases ===
alias ls="ls -h"
alias ll="ls -ahl"
alias cp="cp -p"
alias ld="ls -hl | grep ^d"

alias screen='screen -U -D -RR'

# Settings depending on the OSes
if [ $OSTYPE = "darwin10.8.0" ]; then
  # For Mac only
  alias eject='drutil eject'
  # ESXi
  alias vmstart='ssh esxi vim-cmd vmsvc/power.on'
  alias vmstatus='ssh esxi vim-cmd vmsvc/power.getstate'
  alias vmlist='ssh esxi vim-cmd vmsvc/getallvms'
elif [ $OSTYPE = "linux-gnu" ]; then
  # For Linux only
  alias aptitude='sudo aptitude'
  alias installed='find ~ -type f -name "*history*" | xargs grep "sudo aptitude install" | grep -v find | perl -pe "s/^.+sudo aptitude install (.*)$/\1/g" | perl -pe "s/ /\n/g" | perl -pe "s/^\n//g" | sort -u'
fi

# Gauche + rlwrap
which rlwrap > /dev/null
RC=$?

if [ ${RC} -eq 0 ]; then
  alias gosh="rlwrap -b '(){}[],#\";| ' gosh"
fi

# === Lang ===
export LANG=ja_JP.UTF-8

# === Misc ===
# For Emacs Tramp Access
case "$TERM" in
  dumb | emacs)
    PROMPT="%m:%~> "
    unsetopt zle
    ;;
esac

# http://nijino.homelinux.net/diary/200206.shtml#200206140
if [ "$TERM" = "screen" ]; then
    local -a host; host=`/bin/hostname -s`
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        echo -n "k$host:$cmd[1]:t\\"
    }
fi

# http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
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

# === AWS setting ===

if [ -f ~/.aws_setuprc ]; then
  source ~/.aws_setuprc
fi
