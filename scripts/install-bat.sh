#!/bin/bash

curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
  | grep amd64 \
  | grep musl \
  | cut -d '"' -f 4 \
  | wget -qi -
sudo dpkg -i bat*