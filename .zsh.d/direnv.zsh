which direnv > /dev/null
RC=$?

if [ $RC -eq 0 ]; then
  export EDITOR=/usr/bin/vim
  eval "$(direnv hook zsh)"
fi
