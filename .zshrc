# === Judge OSes ===
function is_darwin(){
  [[ $OSTYPE == darwin* ]] && return 0
  return 1
}

# === Completition ===
autoload -U compinit
compinit

setopt correct

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:default' menu select=1 # 補完メニューをカーソルで選択可能にする。
zstyle ':completion:*:cd:*' tag-order local-directories path-directories # カレントに候補が無い場合のみcdpath 上のディレクトリが候補となる。
setopt list_packed # 補完候補をつめて表示する
setopt auto_menu # TAB で順に補完候補を切り替える
setopt auto_list # 複数の補完候補があったときに、そのリストを自動的に表示
setopt complete_in_word # 補完開始時にカーソルは単語の終端になくても良い。
setopt list_types # 種類を示すマーク表示をつける(ls -fと同じもの)
setopt extended_history # コマンド開始時のタイムスタンプと、実行時間(秒)をヒストリファイルに書き込む。
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える

# === Prediction ===
autoload predict-on
predict-on

# === History ===
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

setopt hist_no_store hist_ignore_dups hist_reduce_blanks hist_ignore_space
setopt incappendhistory sharehistory
setopt extended_history

function history-all { history -E 1 }

# === Key Bind ===
bindkey -e

# === Color ===
autoload -U colors
colors

# === Prompt ===
# http://blog.8-p.info/2009/01/red-prompt
PROMPT="%{$fg[green]%}%n@%m%#%{$reset_color%} "
precmd () {
  PROMPT="%{%(?.$fg[green].$fg[red])%}%n@%m%#%{$reset_color%} "
}

# === Direcotry ===
setopt auto_pushd

# === Aliases ===
alias ls="ls -h"
alias ll="ls -hl"
alias cp="cp -p"
alias ld="ls -hl | grep ^d"
# alias platex="platex --kanji=utf8"

alias cpan="sudo cpan"

alias screen='screen -U -D -RR'

# For Mac Only
is_darwin && alias eject='drutil eject'

# === Path ===
export PATH=/Users/kazu634/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/Applications/UpTeX.app/teTeX/bin:$PATH

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
  chpwd () { echo -n "_`dirs`\\" }
  preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*)
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2)); then
          cmd[1]=$cmd[2]
        fi
        ;&
      *)
        echo -n "k$cmd[1]:t\\"
        return
        ;;
    esac

    local -A jt; jt=(${(kv)jobtexts})

    $cmd >>(read num rest
      cmd=(${(z)${(e):-\$jt$num}})
      echo -n "k$cmd[1]:t\\") 2>/dev/null
  }
  chpwd
fi

# === Directory ===
setopt autopushd
alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
