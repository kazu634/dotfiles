if [ -d $ZDOTDIR -a -r $ZDOTDIR -a \
   -x $ZDOTDIR ]; then
  for i in $ZDOTDIR/*; do
      [[ ${i##*/} = *.zsh ]] &&
          [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi
