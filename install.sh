#!/bin/bash
sudo=true
confirm=true
action=install

packages_all=(
   "curl"
   "redis-server"
   "tmux"
   "jq"
   )
   
source <(curl -s https://raw.githubusercontent.com/CodeSh/getsys/master/getsys)
