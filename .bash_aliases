# Alias definitions.
UNAME=`uname`
function _alias_std() {
    function ls() { $(which ls) --color $@; }
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
    return
}
function _alias_common() {
    function gp() { w=$1; f=$2; shift 2; $(which grep) -nrI "$w" --include "$f" $@; }
    function grep() { $(which grep) --color $@; }
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

