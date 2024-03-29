#!/bin/bash -ex

# coc.nvim dependencies
python2 -m pip install pynvim jedi
python3 -m pip install pynvim jedi
python3 -m pip install yapf isort flake8
pip3 install ruff
npm install -g neovim
npm install -g prettier

# cabal
cabal update
cabal install alex

# rust and cargo crates
# Note: depends on pkg-config libssl-dev
rustup update
cargo install bob-nvim
cargo install cargo-update
cargo install ripgrep
cargo install bat
cargo install stylua
cargo install tree-sitter-cli
cargo install zoxide --locked
cargo install-update -a

# nvm
NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    set +x
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    if nvm install --lts node --reinstall-packages-from=node; then
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
