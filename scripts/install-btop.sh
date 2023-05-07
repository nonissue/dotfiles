#!/bin/bash

# NOTE: Only for linux at the moment

cd ~/tmp

GITHUB_RESULT=$(
  curl -s https://api.github.com/repos/aristocratos/btop/releases/latest |
    grep x86_64 |
    grep musl |
    grep linux |
    cut -d '"' -f 4 |
    xargs echo
)

RELEASE_FILE=$(echo $GITHUB_RESULT | cut -d ' ' -f1)
RELEASE_URL=$(echo $GITHUB_RESULT | cut -d ' ' -f2)

curl -LO $RELEASE_URL
# mkdir ~/tmp/btop
tar -xvjf $RELEASE_FILE -C ~/tmp
cd ~/tmp/btop
sudo make install
sudo make setuid

rm -rf ~/tmp/$RELEASE_FILE
rm -rf ~/tmp/btop

# echo $RELEASE_FILE $RELEASE_URL
