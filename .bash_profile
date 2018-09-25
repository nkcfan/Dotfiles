#!/bin/bash

## Export and config
export TM_C_FLAGS="$TM_C_FLAGS -Wc++11-extensions"
export MANPATH="/usr/local/Cellar:$MANPATH"
export UNAME=`uname`
export GCC_COLORS=1

function _alias_std() {
    alias ls='ls --color '
    alias ll='ls --color -la'
    alias l.='ls --color -d .*'
}
function _alias_osx() {
    alias ls='ls -G '
    alias ll='ls -GFlAhp'
    alias l.='ls -G -d .*'
    alias up='brew update;brew upgrade;brew cask cleanup'
    # f: Opens current directory in MacOS Finder
    alias f='open -a Finder ./'
}
function _alias_linux() {
    alias up='sudo sh -c "apt-get update;apt-get dist-upgrade;apt-get autoremove;apt-get autoclean"'
}
function _alias_common() {
    alias ..='cd ../'                           # Go back 1 directory level
    alias ...='cd ../../'                       # Go back 2 directory levels
    alias ....='cd ../../..'                    # Go back 3 directory levels
    alias 'bk=cd $OLDPWD'
    alias ~="cd ~"                              # Go Home
    alias c='clear'                             # Clear terminal display
    alias psg='ps aux | grep'
    alias unrarall='for f in *.rar;do unrar e "$f";done'
    function gp() { w=$1; f=$2; shift 2; grep -nrI "$w" --include "$f" $@; }
}

## Set aliases
if [[ "$UNAME" == "Linux" ]]; then
    _alias_std
    _alias_linux
elif [[ "$UNAME" == "Darwin" ]]; then # OSX
    _alias_osx
else # Windows
    _alias_std
fi
_alias_common

if [[ "$UNAME" == "Linux" ]]; then
    export PATH="/sbin:/usr/sbin:$PATH"
    if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.rbenv/bin:$HOME/.local/bin:$PATH"
    fi
    # Start the ssh-agent in the background
    source $HOME/bin/ssh-agent.sh
    # Enable rbenv shims and autocompletion
    eval "$(rbenv init -)"
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=true
    # Disable XON/XOFF flow control
    stty -ixon
elif [[ "$UNAME" == "Darwin" ]]; then # OSX
    if [ -d "$HOME/Library/Python/2.7/bin" ]; then
        export PATH="$HOME/Library/Python/2.7/bin:$PATH"
    fi
    export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
    #export EDITOR="/usr/local/bin/mate -w"
    export GIT_EDITOR="/usr/local/bin/mate -w"
    # Enable color in grep
    export GREP_OPTIONS='--color=auto'
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=git-credential-osxkeychain
else # Windows
    #export EDITOR="'$PROGRAMFILES/Notepad++/notepad++.exe'"
    # Set git credential helper for https
    export GIT_CREDENTIAL_HELPER=true
    # Start the ssh-agent in the background
    source $HOME/bin/ssh-agent.sh
fi

BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
DARK="\[\e[1;30m\]"
LRED="\[\e[1;31m\]"
LGREEN="\[\e[1;32m\]"
LYELLOW="\[\e[1;33m\]"
LBLUE="\[\e[1;34m\]"
LPURPLE="\[\e[1;35m\]"
LCYAN="\[\e[1;36m\]"
WHITE="\[\e[1;37m\]"
COLOREND="\[\e[00m\]"

# Responsive Prompt
prompt() {
    if [[ $? -eq 0 ]]; then
        exit_status="${LBLUE}\$ "
        exit_symbol="${LBLUE}✔"
    else
        exit_status="${LRED}\$ "
        exit_symbol="${LRED}✘" 
    fi

    remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
    branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
    if [[ "$remote_state" == "" ]]; then
        rstat=""
    else
        rstat="${CYAN}("
        if [[ "$remote_state" == *ahead* ]] && [[ "$remote_state" == *behind* ]]; then
            ahead_num=$(sed -n 's/\[ahead \([0-9][0-9]*\)[],].*/\1/p' <<< "$remote_state")
            behind_num=$(sed -n 's/.*behind \([0-9][0-9]*\)\]/\1/p' <<< "$remote_state")
            rstat="$rstat${RED}$behind_num,${GREEN}$ahead_num"
        elif [[ "$remote_state" == *ahead* ]]; then
            ahead_num=$(sed -n 's/\[ahead \([0-9][0-9]*\)[],].*/\1/p' <<< "$remote_state")
            rstat="$rstat${GREEN}$ahead_num"
        elif [[ "$remote_state" == *behind* ]]; then
            behind_num=$(sed -n 's/.*behind \([0-9][0-9]*\)\]/\1/p' <<< "$remote_state")
            rstat="$rstat${RED}$behind_num"
        fi

        rstat="$rstat${CYAN})"
    fi

    if [[ $TERM =~ "256color" ]]; then
        host_color="\[\e[38;5;$((16 + $(hostname | cksum | cut -c1-3) % 256))m\]";
    else
        host_color="\[\e[1;$((31 + $(hostname | cksum | cut -c1-3) % 6))m\]";
    fi

    ## Set tmux window title as git repo name or dir name
    base=$(basename `git config --get remote.origin.url || pwd`)
    title=$(perl -pe 's/^((\w{1,2}).*([\-_]))?(\w+)(\.git)?$/\2\3\4/g;' <<< "$base")
    ## Note: \r will move cursor to the beginning ot the line, trick to clear message for non tmux environment
    ## 1. local tmux
    ## 2. tmux in remote client
    printf "\033k$title\033\\ \r"

    PS1="${host_color}\h${exit_symbol}${YELLOW}\w ${CYAN}${branch_name}${rstat}${exit_status}${COLOREND}"
}

export PROMPT_COMMAND=prompt
