#!/bin/bash -e
#
# !! WARNING: Largely untested! May fuck things up. !!
#
# autoinstall.sh
#
# Based on:
# https://newbedev.com/mark-installing-packages-as-auto-installed
#
# Description:
#
# Utility for install build dependencies using apt, and being able to remove them
# after we have completed the build. Eg. when building tmux from source.
#
# Usage:
#
# It accepts arguments as a space delineaated list:
#
# ┌────────────────────────────────────┐
# ┊                                    ┊
# ┊ ./autoinstall byacc bison gcc      ┊
# ┊                                    ┊
# └────────────────────────────────────┘
#
# Specified packages are:
#   - installed IF NOT already installed and marked as 'auto'
#   - marked as manually installed if already installed (so we don't clean them up by accident)
#

NEW_DEPS=$(comm -23 <(xargs -n1 <<< "$@" | sort) <(apt-mark showmanual | sort))
echo $NEW_DEPS

apt install $NEW_DEPS
apt-mark auto $NEW_DEPS