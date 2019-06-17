# WTSN-MOTD

Another waste of time!

## Inspiration / Sources

* https://github.com/yboetz/motd
* https://github.com/djask/motd_scripts

## Preview?

```
for i in /etc/update-motd.d/*; do if [ "$i" != "/etc/update-motd.d/98-fsck-at-reboot" ]; then $i; fi; done
```

## Requirements

Requires:

* figlet
* LOLCAT
