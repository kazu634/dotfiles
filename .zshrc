# === Completition ===
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
setopt extended_history # コマンド開始時のタイムスタンプと、実行時間(秒)をヒストリファイルに書き込む。
setopt auto_param_keys # カッコの対応などを自動的に補完
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える

# For git-completion
autoload bashcompinit
bashcompinit

if [ $OSTYPE = "darwin10.0" ]; then
  # For Mac
  GIT_COMPLETION=`find /usr/local/Cellar/git/ -type f -name "git-completion.bash" | xargs ls -t | head -1`
  source ${GIT_COMPLETION}

elif [ $OSTYPE = "linux-gnu" ]; then
  # for Linux
  if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
  fi
fi

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
#  see: http://d.hatena.ne.jp/mollifier/20100906/p1

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|) [%~]"

# === Direcotry ===
setopt auto_pushd

# === Aliases ===
alias ls="ls -h"
alias ll="ls -hl"
alias cp="cp -p"
alias ld="ls -hl | grep ^d"

alias screen='screen -U -D -RR'

# Settings depending on the OSes
if [ $OSTYPE = "darwin10.0" ]; then
  # For Mac only
  alias eject='drutil eject'
elif [ $OSTYPE = "linux-gnu" ]; then
  # For Linux only
  alias vmstart='sudo virsh start'
  alias vmstop='sudo virsh destroy'
  alias vmlist='sudo virsh list --all'
  alias aptitude='sudo aptitude'
  alias vmcreate='cd /home/kazu634/kvm-hdd && sudo /home/kazu634/bin/vmcreate'
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

# rbenv

if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
fi
