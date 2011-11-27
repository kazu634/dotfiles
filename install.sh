#!/bin/bash

# finding out the shell script directory
CURDIR=`dirname $0`

# finding out the OS type
OS=`uname`

# judging the OS type
if [ $OS = "Linux" ]; then # if linux
  # Linux do not interpret the current directory "." as an absolute one,
  # so we have to change manually.
  if [ $CURDIR = "." ]; then
    CURDIR=`pwd`
  fi

  # copying the .files as a soft link
  find $CURDIR -maxdepth 1 -type f -name ".*" -print0 | xargs -0 -I % ln -s % $HOME 2>/dev/null
else # otherwise (meaning Darwin)
  # copying the .files as a soft link
  find $CURDIR -type f -name ".*" -maxdepth 1 -print0 | xargs -0 -J % ln -s % $HOME 2>/dev/null
fi
