export ZDOTDIR=$HOME/.zsh.d

# === Path ===

case ${OSTYPE} in
  darwin*)
    # For Mac only
    export PATH=/Users/kazu634/bin:$PATH
    ;;
  linux*)
    # For Linux only
    export PATH=/home/kazu634/bin:$PATH
    ;;
esac

# === rbenv ===

case ${OSTYPE} in
  *)
  # for Linux Only
  if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
    PATH=${HOME}/.rbenv/bin:${PATH}
    export PATH
    eval "$(rbenv init - zsh)"
  fi
  ;;
esac

# === nodebrew ===
case ${OSTYPE} in
  *)
  if [ -e /usr/local/bin/nodebrew ]; then
    PATH=${HOME}/.nodebrew/current/bin:${PATH}
    export PATH
  fi
  ;;
esac

# === go ===
case ${OSTYPE} in
  darwin*)
    # For Mac only
    export GOPATH="$HOME/work/go"
    export PATH="$GOPATH/bin:$PATH"
    ;;
  linux*)
  # for Linux Only
  if [ -e ${HOME}/.goenv/bin/goenv ]; then
    export GOENV_ROOT="$HOME/.goenv"
    export GOPATH="$HOME/src"
    export PATH="$GOENV_ROOT/bin:$GOPATH/bin:$PATH"

    eval "$(goenv init -)"
  fi
esac
