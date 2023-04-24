## Fetch the Dotfiles
Run below commands in the home directory, logout and login.

```bash
cd ~
git init
git remote add origin git@github.com:nkcfan/Dotfiles.git
git fetch
git checkout -t origin/master
git branch --set-upstream-to=origin/master
```

## Install the dependencies

### build toolchain
```
sudo apt-get install build-essential
sudo apt-get install pkg-config libssl-dev libxml2-utils universal-ctags clangd
```

### node / npm / nvm
Follow https://github.com/nvm-sh/nvm#installing-and-updating

Follow https://github.com/nvm-sh/nvm#usage to install lts version of node
```
nvm install --lts node --reinstall-packages-from=node
```

### pip
Follow https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py

#### pip packages
```
pip3 install tldr
```

### tpm
Follow https://github.com/tmux-plugins/tpm#installation

### cargo
Follow https://doc.rust-lang.org/cargo/getting-started/installation.html

#### cargo packages
```
cargo install ripgrep
```
