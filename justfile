default:
    @just --list

apt_update:
    sudo apt-get update
apt_install COMMAND PACKAGE=COMMAND:
    #!/bin/bash
    if command -v {{COMMAND}}; then exit 0; fi
    just apt_update
    sudo apt install {{PACKAGE}}

curl: (apt_install "curl")
fzf: (apt_install "fzf")
tmux: (apt_install "tmux")
toolchain: apt_update
    sudo apt install build-essential pkg-config libssl-dev libxml2-utils universal-ctags clangd cmake

NVM_DIR := "$HOME/.nvm"
nvm: curl
    ## TODO: remove hardcoded stable version string
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
node: nvm
    #!/bin/bash
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    set +x
    if nvm install --lts node {{ if `command -v node` != "" { "--reinstall-packages-from=node" } else { "" } }}; then
        nvm alias default node
        echo 'Please `nvm uinstall` old versions!'
        if [ -d "~/.config/coc/extensions" ]; then
            pushd ~/.config/coc/extensions
            npm rebuild
            popd
        fi
    fi
    set -x
npm: nvm
    #!/bin/bash
    # TODO: no need to upgate npm, since it is managed by nvm
    #npm install -g npm@latest
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install-latest-npm
    npm update -g
npm_install PACKAGE: npm
    npm install -g {{PACKAGE}}
diff: (npm_install "diff-so-fancy")

tpm: tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rust:
    #!/bin/bash
    if command -v rustc; then exit 0; fi
    curl https://sh.rustup.rs -sSf | sh
rust_update: rust
    rustup update
cargo:
    #!/bin/bash
    if command -v cargo; then exit 0; fi
    just rust toolchain
cargo_install PACKAGE: cargo
    cargo install {{PACKAGE}}
bat: (cargo_install "bat")
stylua: (cargo_install "stylua")
zoxide: (cargo_install "zoxide")
ripgrep: (cargo_install "ripgrep")
tree-sitter-cli: (cargo_install "tree-sitter-cli")
cargo-update: (cargo_install "cargo-update")
    cargo install-update -a

# neovim
bob-nvim: (cargo_install "bob-nvim")
nvim: bob-nvim
    bob use stable
