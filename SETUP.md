# Setup

Inspiration: 

* https://github.com/alrra/dotfiles/blob/master/src/os/create_symbolic_links.sh
* https://github.com/paulirish/dotfiles/blob/master/symlink-setup.sh

## Links

```bash
ln -s ~/.dotfiles/nvim/ ~/.config/nvim
ln -s ~/.dotfiles/fish/ ~/.config/fish
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/glances/ ~/.config/glances
ln -s ~/.dotfiles/vscode ~/Library/Application\ Support/Code/User/
ln -s ~/.dotfiles/bin/crontest /usr/local/bin/
```

## System Configs

* change capslock to control
* make dirs:
	* ~/code
	* ~/nosync

### Packages

#### All OS
* git
* tmux
* neovim
	* plug: curl -fLo ~/.dotfiles/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
* fish
* z
* fzf
* tree
* fd
* node
* npm
* yarn

#### macOS

* Homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
* hammerspoon
* xcode developer tools (brew does do this)
* refind

## Linux Installations

### Add backports

Allows us to install packages not available on 18.04 (or newer versions of said packages)

```bash
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
sudo apt-key adv --keyserver keyserver.ubuntu.com 171 --recv-keys 648ACFD622F3D138
sudo apt-get update
```

### Neovim

```bash
sudo add-apt-repository ppa:neovim-ppa/stable 
sudo apt-get update
sudo apt-get install neovim
# Plugin Manager
curl -fLo ~/.dotfiles/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Fish 

```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
```

### Bat

```bash
curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
  | grep amd64 \
  | grep musl \
  | cut -d '"' -f 4 \
  | wget -qi -
sudo dpkg -i bat*
```

### FZF

```bash
# As of 20-10-16
sudo apt install fzf
sudo apt install fdfind
```

### Node

```bash
sudo apt install nodejs
sudo apt install npm
curl -o- -L https://yarnpkg.com/install.sh | bash
```

### Tmux

```bash
sudo apt install tmux
# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Python3/Pip

```bash
# This seems to update ubuntu python3 as well ¯\_(ツ)_/¯
sudo apt install python3-pip
```

### Glances

```bash
pip3 install glances --user
```

### Docker

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# have to run below in bash, fish chokes
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	 $(lsb_release -cs) 
	 stable"

sudo apt-get update
sudo apt-get install linux-generic-hwe-18.04 # unlisted docker dependency
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker ops # add my user to docker group
```

### Symlinks

```bash
# Should run dotbot
./install
```