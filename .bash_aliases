# Alias definitions.
UNAME=`uname`
function _alias_std() {
    function ls() { $(which ls) --color "$@"; }
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
    function gp() { w=$1; f=$2; shift 2; $(which grep) -nrI "$w" --include "$f" "$@"; }
    function grep() { $(which grep) --color "$@"; }
    function egrep() { $(which egrep) --color "$@"; }
    # Python command line client for tldr
    function tldr() { LANG=en_us.UTF8 $(which tldr) "$@"; }
    # ripgrep without heading
    # Note: -n is needed for non-tty to get line number
    function rg () { $(which rg) -n --no-heading "$@"; }
    # node will disapear after nvm upgrade/uninstall in another session
    function node() {
        local bin
        if ! bin=`which node`; then
            nvm use default 2>&1 > /dev/null
            if ! bin=`which node`; then
                bin="node"
            fi
        fi
        ${bin} "$@"
    }
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

