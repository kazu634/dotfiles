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

# === Prediction ===
autoload predict-on
predict-on

# === History ===
HISTFILE=~/.zhistory
SAVEHIST=10000

setopt hist_no_store hist_ignore_dups hist_reduce_blanks hist_ignore_space
setopt incappendhistory sharehistory

# === Key Bind ===
bindkey -e

# === Color ===
autoload -U colors
colors

# === Prompt ===
RPROMPT="%~ [%h]"
PROMPT+="%B$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /')%b%{${reset_color}%}"

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
