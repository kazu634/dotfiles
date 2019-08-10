# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kazu634/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/kazu634/.fzf/bin"
  export FZF_DEFAULT_OPTS='--color=fg+:11 --cycle --reverse --height=80% --exit-0 --bind=ctrl-j:accept --no-sort'
fi

