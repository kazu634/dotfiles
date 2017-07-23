: Prompt && {
  : SSH接続 or 通常時でプロンプトの色を変更する && {
    if [ -n "$SSH_CONNECTION" ]; then
        PROMPT="%{$fg[blue]%}%n@%m%#%{$reset_color%} "
    else
        PROMPT="%{$fg[green]%}%n@%m%#%{$reset_color%} "
    fi

    precmd () {
        if [ -n "$SSH_CONNECTION" ]; then
            PROMPT="%{%(?.$fg[blue].$fg[red])%}%n@%m%#%{$reset_color%} "
        else
            PROMPT="%{%(?.$fg[green].$fg[red])%}%n@%m%#%{$reset_color%} "
        fi
    }
  }
}
