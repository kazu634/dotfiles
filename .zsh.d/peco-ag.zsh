: peco + ag integration && {
  function peco-file() {
    local filepath=$(ag -l | peco --prompt 'PATH >')
    if [ -n "$filepath" ]; then
      if [ -n "$BUFFER" ]; then
        BUFFER="$BUFFER $(echo $filepath | tr '\n' ' ')"
        CURSOR=$#BUFFER
      else
        if [ -f "$filepath" ]; then
          BUFFER="/usr/local/bin/vim $filepath"
          zle accept-line
        fi
      fi
    fi
  }

  zle -N peco-file
  bindkey '^g' peco-file
}
