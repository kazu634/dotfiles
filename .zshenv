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

if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
  PATH=${HOME}/.rbenv/bin:${PATH}
  export PATH
  eval "$(rbenv init - zsh)"
fi
