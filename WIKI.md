# Wiki

## macOS Tips

### Stop Spotlight Indexing of node_modules

```bash
find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;
```

## General

### Update PlexMediaServer

```bash
curl -s "https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu" | grep -Po '(?<=url=\")(\S+)(?=\")' | xargs curl -O
```

## Ubuntu Issues

### Python

* The python situation on whats.one is a mess. Multiple versions installed, conflicts, etc. 
* Had to modify `add-apt-repository` to reference python 3.6 rather than default python3 version (3.7.5).
    * `sudo vim /usr/bin/add-apt-repository`

### Commands 

```bash
# scan disk space usage without crossing fs boundaries
ncdu -x /

# check virt memory usage, sorted
ps -e -o pid,vsz,comm= | sort -n -k 2
```
