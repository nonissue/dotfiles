#!/usr/bin/env bash

# MIT licensed
# Heavily borrowed from: 
# ben alman / https://github.com/cowboy/dotfiles










###########################################
# Warnign: Not currently implemented!
###########################################










[[ "$1" == "source" ]] || \

echo 'nonissue dotfiles - nonissue.org'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP
Usage: $(basename "$0")

HELP
exit; fi

###########################################
# GENERAL PURPOSE EXPORTED VARS / FUNCTIONS
###########################################

# Where the magic happens.
export DOTFILES=~/.dotfiles

function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function is_ubuntu_desktop() {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}
function get_os() {
  for os in osx ubuntu ubuntu_desktop; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}


