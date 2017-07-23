: Aliases && {
  alias ls="ls -h"
  alias ll="ls -ahl"
  alias cp="cp -p"
  alias ld="ls -hl | grep ^d"

  alias screen='screen -U -D -RR'
  alias tmux="if tmux has; then tmux attach; else tmux new; fi"

  # Settings depending on the OSes
  case ${OSTYPE} in
    darwin*)
      # For Mac
      alias eject='drutil eject'
      # vim
      alias vi='/usr/local/bin/vim'
      ;;

    linux*)
      # For Linux only
      alias aptitude='sudo aptitude'
      alias apt='sudo apt'
      ;;
  esac
}
