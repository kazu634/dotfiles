export ZDOTDIR=$HOME/.zsh.d

# === nodebrew ===
case ${OSTYPE} in
  *)
  if [ -e /${HOME}/.nodebrew/nodebrew ]; then
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
