#!/bin/bash -ex

# cargo crates
cargo install cargo-update
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
    fi
    set -x
fi

# npm
# TODO: no need to upgate npm, since it is managed by nvm
#npm install -g npm@latest
npm update -g

# pip
pip2 install pip-review
python2 -m pip_review --interactive
pip3 install pip-review
python3 -m pip_review --interactive
