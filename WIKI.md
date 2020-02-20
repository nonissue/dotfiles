# Wiki

## macOS Tips

### Stop Spotlight Indexing of node_modules

```
find . -type d -name "node_modules" -exec touch "{}/.metadata_never_index" \;
```
