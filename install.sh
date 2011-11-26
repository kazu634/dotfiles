#!/bin/bash

# finding out the shell script directory
CURDIR=`dirname $0`

# copying the .files as a soft link
find $CURDIR -type f -name ".*" -maxdepth 1 -print0 | xargs -0 -J % ln -s % $HOME 2>/dev/null
