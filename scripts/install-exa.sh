#!/bin/bash

# NOTE: Only for linux at the moment
# NOTE: NOT WORKING!!!

# Todo:
# - [ ] cleanup
# - [ ] better copy / install (rather than just plunking binary in ~/.local/bin)
# - [ ] print status at end (success/fail)
# - [ ] print version at the end

echo \n"Installing latest version of exa..."
echo "Note: This script is Ubuntu only!"
echo ""
cd ~/tmp

GITHUB_RESULT=$(
  curl -s https://api.github.com/repos/ogham/exa/releases/latest |
    grep x86_64 |
    grep musl |
    grep linux |
    cut -d '"' -f 4 |
    xargs echo
)

RELEASE_FILE=$(echo $GITHUB_RESULT | cut -d ' ' -f1)
RELEASE_URL=$(echo $GITHUB_RESULT | cut -d ' ' -f2)

mkdir ~/tmp/exa
curl -LO $RELEASE_URL
unzip $RELEASE_FILE -d ~/tmp/exa

cd ~/tmp/exa
cp ~/tmp/exa/bin/exa ~/.local/bin/exa
cp ~/tmp/exa/completions/exa.fish ~/.dotfiles/fish/completions/exa.fish
cd -

echo ""
echo "Installed: "
echo $(exa --version | sed -n 's/\(v[0-9]\.[0-9][0-9].[0-9]\).*/\1/p')
echo ""

# this doesn't require return
# read -p "Clean up? (y/n) " -n 1 -r

# requires a return after input
# I think this is more idiomatic and predictable
read -p "Clean up? (y/n) " -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Cleaning up!"
  if [ -d ~/tmp/exa ]; then
    rm -r ~/tmp/exa
    echo "Removed ~/tmp/exa"
  fi
  if [ -f ~/tmp/$RELEASE_FILE ]; then
    rm ~/tmp/$RELEASE_FILE
    echo "Removed "$RELEASE_FILE
  fi

  echo "Clean up complete, installation complete. Later!"
fi

# rm -rf ~/tmp/$RELEASE_FILE
# rm -r ~/tmp/exa

# echo $RELEASE_FILE $RELEASE_URL
