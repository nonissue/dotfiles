# macOS Setup

## Installations

## PreReqs

- XCode Command Line Tools
- SSH Keys
- Git
- homebrew
  - `set -U fish_user_paths /opt/homebrew/bin $fish_user_paths`

### Apps

- VSCode
  - Install `shell command` as well
- 1Password
- Hammerspoon
- AdGuard
- Raycast
- Raindrop
- Mimestream

### Utilities

- fish shell
  - add fish shell to `/etc/shells`
    - `sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'`
  - `chsh -s (which fish)`
- tmux
- exa
- bat
- VSCode

### Safari Extensions

### Fonts

- MonoLisa
- FiraCode
- NerdFonts

## Todo

### Missing Symlinks

- `iterm`
  - Settings located here:
  - `/Users/apw/.dotfiles/iterm/profiles/beta`
- `vscode` config (or just sync with github?)
-

### Editor

- Fix fish/homebrew paths
