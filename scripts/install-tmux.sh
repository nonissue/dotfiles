#!/bin/bash

sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc
git clone https://github.com/tmux/tmux.git ~/tmp/tmux; 
cd ~/tmp/tmux; 
./autogen.sh; ./configure && make; 
sudo make install; tmux kill-server; 
tmux -V; 
# RM doesn't work fully i don't think?
# rm -rf ~/tmp/tmux;
# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm