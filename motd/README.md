# WTSN-MOTD

Another waste of time!

## Inspiration / Sources

- https://github.com/yboetz/motd
- https://github.com/djask/motd_scripts

## Preview?

```
for i in /etc/update-motd.d/*; do if [ "$i" != "/etc/update-motd.d/98-fsck-at-reboot" ]; then $i; fi; done
```

## Requirements

Requires:

- figlet
- LOLCAT

## Install Instructions

```
cd /etc/update-motd.d
sudo mkdir archive
sudo mv * archive/
sudo ln -s ~/.dotfiles/motd/* .
sudo apt install figlet lolcat -y
cd /usr/share/figlet
sudo curl -O 'https://www.figlet.org/fonts/roman.flf'
cd /etc/update-motd.d
./preview.sh
```

## Misc notes

- Find figlet default font directory: `figlet -I 2`.
