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

Symlinking is automated by dotbot. The `scripts/install-motd.sh` helper (wired into
`install.conf.yaml` via a Linux-guarded `shell:` entry) archives any distro-default
scripts once, then symlinks only the numbered MOTD scripts into `/etc/update-motd.d`.
It is idempotent, so it's safe to re-run on every bootstrap — it will prompt for sudo
since writing to `/etc` requires root.

Running the dotfiles installer on a Linux host is enough:

```
~/.dotfiles/install
```

The dependencies still need to be installed manually:

```
sudo apt install figlet lolcat -y
cd /usr/share/figlet
sudo curl -O 'https://www.figlet.org/fonts/roman.flf'
~/.dotfiles/motd/preview.sh
```

### Manual symlinking (if needed)

```
cd /etc/update-motd.d
sudo mkdir archive
sudo mv * archive/
# Link only the numbered scripts (avoid symlinking README.md / preview.sh,
# which run-parts would otherwise execute on login)
sudo ln -sfn ~/.dotfiles/motd/[0-9]* .
```

## Misc notes

- Find figlet default font directory: `figlet -I 2`.
