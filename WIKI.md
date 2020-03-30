# Wiki

## macOS Tips

### Stop Spotlight Indexing of node_modules

```
find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;
```

## General

### Update PlexMediaServer

```
curl -s "https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=16&distro=ubuntu" | grep -Po '(?<=url=\")(\S+)(?=\")' | xargs curl -O
```
