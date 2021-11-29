#!/bin/bash

# Install deps
sudo apt install -y build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc

# Switch to autoinstall in future?
# sudo ./autoinstall.sh build-essential autoconf automake pkg-config libevent-dev libncurses5-dev bison byacc

# Clone source, gen, config, make, install
git clone https://github.com/tmux/tmux.git ~/tmp/tmux; 
cd ~/tmp/tmux; ./autogen.sh; ./configure && make; sudo make install; 

tmux kill-server; tmux -V; # verfiy version in path is what we expected

# Install plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm