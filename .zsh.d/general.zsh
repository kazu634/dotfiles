: Lang && {
  export LANG=ja_JP.UTF-8
}

: Direcotry && {
  setopt auto_pushd
  setopt PUSHD_IGNORE_DUPS
}

: Key Bind && {
  bindkey -e
}

: Color && {
  autoload -U colors
  colors
}


: General completion && {
  autoload -U compinit
  compinit

  setopt correct

  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
  # 補完メニューをカーソルで選択可能にする。
  zstyle ':completion:*:default' menu select=1
  # カレントに候補が無い場合のみcdpath 上のディレクトリが候補となる
  zstyle ':completion:*:cd:*' tag-order local-directories path-directories
  # 補完でキャッシュを有効にする
  zstyle ':completion:*' use-cache true
  # 補完時のファイル名を黄色で表示
  zstyle ':completion:*' list-colors di=33 fi=0

  setopt list_packed      # 補完候補をつめて表示する
  setopt auto_menu        # TAB で順に補完候補を切り替える
  setopt auto_list        # 複数の補完候補があったときに、そのリストを自動的に表示
  setopt complete_in_word # 補完開始時にカーソルは単語の終端になくても良い。
  setopt list_types       # 種類を示すマーク表示をつける(ls -fと同じもの)
  setopt auto_param_keys  # カッコの対応などを自動的に補完
  setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
}

: Prediction && {
  autoload predict-on
  predict-on
}

: History && {
  HISTFILE=$HOME/.zhistory
  HISTSIZE=100000
  SAVEHIST=100000

  setopt hist_no_store hist_ignore_dups hist_reduce_blanks hist_ignore_space
  setopt incappendhistory sharehistory
  setopt extended_history
  setopt hist_ignore_all_dups extended_history
  setopt hist_save_no_dups

  function history-all { history -E 1 }
}
