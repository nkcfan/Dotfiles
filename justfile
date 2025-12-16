default:
    @just --list

apt_update:
    sudo apt-get update
apt_install *PACKAGE:
    #!/bin/bash
    just apt_update
    sudo apt install {{PACKAGE}}
apt_try_install COMMAND PACKAGE=COMMAND *EXTRA_PACKAGES:
    #!/bin/bash
    if command -v {{COMMAND}}; then exit 0; fi
    just apt_install {{PACKAGE}}
    just apt_install {{EXTRA_PACKAGES}}

toolchain:
    just apt_install build-essential pkg-config libssl-dev libxml2-utils universal-ctags clangd cmake
curl: (apt_try_install "curl")
    just apt_install ca-certificates
tmux: (apt_try_install "tmux" "tmux" "ncurses-term")
augtool: (apt_try_install "augtool" "augeas-tools")

NVM_DIR := "$HOME/.nvm"
nvm: curl
    ## TODO: remove hardcoded stable version string
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
node: nvm
    #!/bin/bash
    source "$NVM_DIR/nvm.sh"  # This loads nvm
    set +x
    if nvm install --lts node {{ if `command -v node || true` != "" { "--reinstall-packages-from=node" } else { "" } }}; then
        nvm alias default node
        echo 'Please `nvm uinstall` old versions!'
        if [ -d "~/.config/coc/extensions" ]; then
            pushd ~/.config/coc/extensions
            npm rebuild
            popd
        fi
    fi
    set -x
npm: node
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

# docker
docker:
    #!/bin/bash
    if command -v docker; then exit 0; fi
    # Uninstall all conflicting packages
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
    # Add Docker's official GPG key:
    just curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    just apt_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker_post: docker
    sudo usermod -aG docker $USER
    @echo 'Log out and log back in so that your group membership is re-evaluated'

avahi:
    just apt_install avahi-daemon
    just augtool
    # sudo augtool --autosave "set /files/etc/avahi/avahi-daemon.conf/publish/publish-addresses yes"
    # sudo service avahi-daemon restart
avahi-utils:
    just apt_install avahi-utils

# power management
logind:
    sudo augtool --autosave "set /files/etc/systemd/logind.conf/Login/HandlePowerKeyLongPress/value poweroff"
    sudo augtool --autosave "set /files/etc/systemd/logind.conf/Login/HandleLidSwitch/value ignore"
