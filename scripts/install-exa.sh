#!/bin/bash

# NOTE: Only for linux at the moment
# NOTE: NOT WORKING!!!

cd ~/tmp


GITHUB_RESULT=$(curl -s https://api.github.com/repos/ogham/exa/releases/latest \
  | grep x86_64 \
  | grep musl \
  | grep linux \
  | cut -d '"' -f 4 \
  | xargs echo
)

RELEASE_FILE=$(echo $GITHUB_RESULT | cut -d ' ' -f1)
RELEASE_URL=$(echo $GITHUB_RESULT | cut -d ' ' -f2)

mkdir ~/tmp/exa
curl -LO $RELEASE_URL
unzip $RELEASE_FILE -d ~/tmp/exa
# tar -xvjf $RELEASE_FILE -C ~/tmp
cd ~/tmp/exa

cp ~/tmp/exa/bin/exa ~/.local/bin/exa
cp ~/tmp/exa/completions/exa.fish ~/.dotfiles/fish/completions/exa.fish
cd -
# rm -r ~/tmp/exa
# sudo make install
# sudo make setuid

# rm -rf ~/tmp/$RELEASE_FILE
# rm -rf ~/tmp/btop

# echo $RELEASE_FILE $RELEASE_URL
