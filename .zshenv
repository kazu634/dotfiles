# === Path ===

if [ $OSTYPE = "darwin10.0" ]; then
  # For Mac only
  export PATH=/Users/kazu634/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/texlive/2011/bin/universal-darwin/:$PATH
elif [ $OSTYPE = "linux-gnu" ]; then
  # For Linux only
  export PATH=/home/kazu634/bin:$PATH
fi

# === rbenv ===

if [ -e ${HOME}/.rbenv/bin/rbenv ]; then
  PATH=${HOME}/.rbenv/bin:${PATH}
  eval "$(rbenv init - zsh)"
fi
