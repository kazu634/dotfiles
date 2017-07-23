# === rbenv ===
case ${OSTYPE} in
  *)
    # for Linux Only
    if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
      export PATH="${HOME}/.rbenv/bin:${PATH}"
      eval "$(rbenv init - zsh)"
    fi
    ;;
esac
