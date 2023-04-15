# 22-08-14

## Issues

- syntax highlighting was not working with neovim + AstroVim on ubuntu 18.04 (hetz)
- tried everything to fix it
- eventually realized it might be because I had neovim 0.8 installed which is buggy.
- unfortunately neovim 0.6 isn't compatible with my version of astrovim

## Solution

- downloaded latest nvim 0.7 linux release from github
- unpacked it
- moved the dir that got unpacked to `~/.local/bin`
- Set up symlink pointing to binary in `~/.local/bin/nvim/bin/nvim`
- NOTE: 
  - the symlink must point to the binary in the `nvim-linux64/bin` folder otherwise it won't work.
  - you can't just `cp nvim-linux64/bin/nvim /usr/local/bin/nvim` as it is not standalone and relies on other files in `nvim-linux64`
- `sudo ln -s ~/.local/bin/nvim-linux64/bin/nvim /usr/local/bin/nvim`

Anyway, that seemed tofix unordered list fix it?

