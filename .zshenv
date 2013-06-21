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
  linux*)
  # for Linux Only
  if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
    PATH=${HOME}/.rbenv/bin:${PATH}
    export PATH
    eval "$(rbenv init - zsh)"
  fi
  ;;
  darwin*)
  # for Mac Only
  if [ -e /usr/local/bin/rbenv ]; then
    PATH=${HOME}/.rbenv/bin:${PATH}
    export PATH
    eval "$(/usr/local/bin/rbenv init - zsh)"
  fi
  ;;
esac
