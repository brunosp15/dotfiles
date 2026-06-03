#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export PATH=$PATH:$HOME/go/bin:$HOME/sdk/dart-sdk/bin    


alias grep='grep --color=auto'
alias way="pkill waybar && waybar"
alias bashconfig='nvim ~/.bashrc'
alias reload='source ~/.bashrc'
alias hyprconfig='nvim ~/.config/hypr/hyprland.lua'
alias nvimconfig='nvim ~/.config/nvim/init.lua'
alias i='sudo pacman -S'
alias ls='ls -la --color'
alias cd='z'

alias gst='git status'

 
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups:ignorespace

shopt -s histappend

PROMPT_COMMAND="history -a; history -n"


eval "$(zoxide init bash)"
eval "$(starship init bash)"
eval "$(fzf --bash)"

