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
