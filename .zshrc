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

BLACK=$'\e[0;30m'
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
PURPLE=$'\e[0;35m'
CYAN=$'\e[0;36m'
GRAY=$'\e[0;37m'
DARK=$'\e[1;30m'
LRED=$'\e[1;31m'
LGREEN=$'\e[1;32m'
LYELLOW=$'\e[1;33m'
LBLUE=$'\e[1;34m'
LPURPLE=$'\e[1;35m'
LCYAN=$'\e[1;36m'
WHITE=$'\e[1;37m'
COLOREND="%F{reset_color}"

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
        host_color="%F{$((16 + $(hostname | cksum | cut -c1-3) % 256))}";
    else
        host_color="\[\e[1;$((31 + $(hostname | cksum | cut -c1-3) % 6))m\]";
    fi

    # Set tmux window title as git repo name or dir name
    base=$(basename `git config --get remote.origin.url || pwd`)
    title=$(perl -pe 's/^((\w{1,2}).*([\-_]))?(\w+)(\.git)?$/\2\3\4/g;' <<< "$base")
    printf "\ek$title\e\\"
    ## Clear from cursor to beginning of the line
    echo -ne "\e[1K\r"

    PS1="${CYAN}${debian_chroot:+($debian_chroot)}${YELLOW}${venv_name}${host_color}%m${exit_symbol}${YELLOW}%~ ${CYAN}${branch_name}${rstat}${exit_status}${COLOREND}%b "
}

if [ "$color_prompt" = yes ]; then
    export PROMPT_COMMAND=prompt
    precmd_functions+=prompt
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


# Setting the default source for fzf
export FZF_DEFAULT_COMMAND=$HOME/bin/ripgrep_git.sh
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Ctrl-R to popup command history
export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion (only available in 0.48.0 or later)
bindkey -rM emacs '\C-t'
bindkey -rM vicmd '\C-t'
bindkey -rM viins '\C-t'
zle     -N              fzf-file-widget
bindkey -M emacs '\C-p' fzf-file-widget
bindkey -M vicmd '\C-p' fzf-file-widget
bindkey -M viins '\C-p' fzf-file-widget

# Arrow to search history
# ref: https://unix.stackexchange.com/a/97844/161486
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
