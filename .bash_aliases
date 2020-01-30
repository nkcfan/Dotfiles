# Alias definitions.
UNAME=`uname`
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

    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
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

