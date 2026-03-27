alias ll="ls -la --color=auto"
alias reload="source ~/.config/zsh/.zshrc"
alias config="nvim ~/.config"
alias i="sudo pacman -S"

alias n="nvim"
alias gst="git status"

setopt SHAREHISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files

fpath=($ZDOTDIR/prompt $fpath)
autoload -Uz prompt_purification_setup; prompt_purification_setup


source <(fzf --zsh)

# PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '

