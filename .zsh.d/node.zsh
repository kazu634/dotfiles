# === nodebrew ===
case ${OSTYPE} in
  *)
  if [ -e /${HOME}/.nodebrew/nodebrew ]; then
    PATH=${HOME}/.nodebrew/current/bin:${PATH}
    export PATH
  fi
  ;;
esac
