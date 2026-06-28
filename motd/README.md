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

## Figlet setup

1. Find figlet default font directory: `figlet -I 2`.
2. Install `roman.fif` to this dir (used to use isometric3.flf)

```
cd /usr/share/figlet
sudo curl -O 'https://www.figlet.org/fonts/roman.flf'
```
