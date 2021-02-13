# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    *-*color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        color_prompt=yes
    else
        color_prompt=
    fi
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
        exit_status="${LBLUE}\$"
        exit_symbol="${LBLUE}✓"
    else
        exit_status="${LRED}\$"
        exit_symbol="${LRED}✘"
    fi

    remote_state=$(git status -sb 2> /dev/null | grep -oh "\[.*\]")
    branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
    venv_name=$([[ -n "$VIRTUAL_ENV" ]] && echo "${VIRTUAL_ENV##*/} ")

    # Git ahead/behind numbers
    rstat=""
    if [[ "$remote_state" == *ahead* ]]; then
        ahead_num=$(sed -n 's/\[ahead \([0-9][0-9]*\)[],].*/\1/p' <<< "$remote_state")
        rstat="$rstat${GREEN}⇡$ahead_num"
    fi
    if [[ "$remote_state" == *behind* ]]; then
        behind_num=$(sed -n 's/.*behind \([0-9][0-9]*\)\]/\1/p' <<< "$remote_state")
        rstat="$rstat${RED}⇣$behind_num"
    fi

    if [[ $TERM =~ "256color" ]]; then
        host_color="\[\e[38;5;$((16 + $(hostname | cksum | cut -c1-3) % 256))m\]";
    else
        host_color="\[\e[1;$((31 + $(hostname | cksum | cut -c1-3) % 6))m\]";
    fi

    # Set tmux window title as git repo name or dir name
    base=$(basename `git config --get remote.origin.url || pwd`)
    title=$(perl -pe 's/^((\w{1,2}).*([\-_]))?(\w+)(\.git)?$/\2\3\4/g;' <<< "$base")
    printf "\ek$title\e\\"
    ## Clear from cursor to beginning of the line
    echo -ne "\e[1K\r"

    PS1="${CYAN}${debian_chroot:+($debian_chroot)}${YELLOW}${venv_name}${host_color}\h${exit_symbol}${YELLOW}\w ${CYAN}${branch_name}${rstat}${exit_status}${COLOREND} "
}

if [ "$color_prompt" = yes ]; then
    export PROMPT_COMMAND=prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Setting fd as the default source for fzf
UNAME=`uname`
if [[ "$UNAME" == "Linux" ]]; then
    export FZF_DEFAULT_COMMAND='{ rg --files --hidden & git ls-files; } | sort -u'
else # Windows
    export FZF_DEFAULT_COMMAND='( rg --files --path-separator "//" & git ls-files ) | sort /unique'
fi
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Key mappings for fzf
# ref: https://github.com/junegunn/fzf/issues/546#issuecomment-213891483
bind -x '"\C-p": fzf-file-widget'
bind '"\C-t": transpose-chars'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
