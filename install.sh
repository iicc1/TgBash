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
   
source getsys/getsys
