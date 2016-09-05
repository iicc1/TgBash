#!/bin/bash

if [ "$1" ]; then
  clear
  declare -a DATE
  DATE=$(date +%F)
  grep=$(cat $1 | grep -E [0-9] | sed 's/,//g')
  perl -pi -e "s[GBANS=\(][GBANS=\(\n$grep]g" data/gbans.sh
  echo -e '\e[0;32mList exported sucessfully\e[0m' || echo -e '\e[0;31mError. The file not exist.\e[0m'
fi

if [ ! "$1" ]; then
  clear
  echo -e '\e[0;31mError. You need set the filename then\e[0m'
fi
