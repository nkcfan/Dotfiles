# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# if running zsh
if [ -n "$ZSH_NAME" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        . "$HOME/.zshrc"
    fi
fi

# If ssh-agent does not represent any identities, start ssh-agent and add identity
if ! ssh-add -l; then
    . "$HOME/bin/ssh-agent.sh"
fi

# ref: https://unix.stackexchange.com/a/217629/161486
pathmunge() {
    if [ -d "$1" ]; then
        if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)" ; then
            if [ "$2" = "after" ] ; then
                PATH="$PATH:$1"
            else
                PATH="$1:$PATH"
            fi
        fi
    fi
}

# set PATH so it includes user's private bin if it exists
pathmunge "$HOME/.local/bin"
pathmunge "$HOME/.local/share/bob/nvim-bin"
pathmunge "$HOME/.rbenv/bin"
pathmunge "$HOME/.cargo/bin"
pathmunge "$HOME/.cargo/env"
pathmunge "$HOME/.yarn/bin"
pathmunge "$HOME/.config/yarn/global/node_modules/.bin"
pathmunge "$HOME/.cabal/bin"
pathmunge "$HOME/go/bin"
pathmunge "$HOME/bin"
pathmunge "$HOME/Library/Python/2.7/bin"
pathmunge /opt/local/sbin
pathmunge /opt/local/bin
pathmunge /usr/local/bin
pathmunge /usr/sbin
pathmunge /sbin

export PATH
export MANPATH="/usr/local/Cellar:$MANPATH"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#export GCC_COLORS=1

export TM_C_FLAGS="$TM_C_FLAGS -Wc++11-extensions"

UNAME=`uname`
if [[ "$UNAME" == "Linux" ]]; then
    export EDITOR="vi"
    # Enable rbenv shims and autocompletion
    eval "$(rbenv init -)"
    # Set manpage to use color
    # Note: please install most package
    export MANPAGER=most
    # Set git pager
    export GIT_PAGER="( diff-so-fancy || cat ) | less --tabs=4 -RFX"
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=true
    export GCM_CREDENTIAL_STORE=cache
    # Disable XON/XOFF flow control
    stty -ixon
elif [[ "$UNAME" == "Darwin" ]]; then # OSX
    #export EDITOR="/usr/local/bin/mate -w"
    #export GIT_EDITOR="/usr/local/bin/mate -w"
    # Enable color in grep
    export GREP_OPTIONS='--color=auto'
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=git-credential-osxkeychain
    # Using tmux-256color on macOS
    # ref: https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos/
    export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo
else # Windows
    #export EDITOR="'$PROGRAMFILES/Notepad++/notepad++.exe'"
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=true
    # Enable syslink
    export MSYS=winsymlinks:nativestrict
fi

