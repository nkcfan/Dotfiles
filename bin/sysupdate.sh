#!/bin/bash -ex

# coc.nvim dependencies
python2 -m pip install pynvim jedi
python3 -m pip install pynvim jedi
npm install -g neovim

# cargo crates
# Note: depends on pkg-config libssl-dev
cargo install cargo-update
cargo install ripgrep
cargo install bat
cargo install-update -a

# nvm
NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    set +x
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    if nvm install node --reinstall-packages-from=node; then
        nvm alias default node
        pushd ~/.config/coc/extensions
        npm rebuild
        popd
        echo 'Please `nvm uinstall` old versions!'
    fi
    set -x
fi

# npm
# TODO: no need to upgate npm, since it is managed by nvm
#npm install -g npm@latest
nvm install-latest-npm
npm update -g

# pip
pip2 install pip-review
python2 -m pip_review --interactive
pip3 install pip-review
python3 -m pip_review --interactive

# go
go get -u all
