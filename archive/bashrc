#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# --- Custom Workstation Aliases & Functions ---
alias ls="ls --color=auto -F"
alias ll="ls -l --color=auto -Fhoa"
alias fetch="fastfetch -l ~/.config/ReaperBadge.txt"
alias hype="nvim ~/.config/hypr/hyprland.lua"
alias cl="clear"
alias vial="QT_SCALE_FACTOR=1.5 vial"

gimmie() {
    sudo pacman -S "$@"
}
gitupdate() {
    if [ "$1" == "--help" ]; then
        echo "Usage: gitupdate {commit message}"
        return 0
    fi

    if [ -z "$1" ]; then
        echo "Error: missing argument"
        echo "Use --help for usage"
        return 1
    fi

    git add .
    git commit -m "$*"
    git push origin main
}


# Modern Clean Bash Prompt

# Colors
RESET="\[\e[0m\]"
BOLD="\[\e[1m\]"
CYAN="\[\e[36m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
RED="\[\e[31m\]"
BLUE="\[\e[34m\]"
GRAY="\[\e[90m\]"
PURPLE="\[\e[38;2;138;111;209m\]"

# Build the prompt dynamically
set_bash_prompt() {
    local EXIT_CODE="$?"

    # Symbol that turns red if the last command failed
    local PROMPT_SYMBOL="${GREEN}\n❯${RESET}"
    if [ $EXIT_CODE -ne 0 ]; then
        PROMPT_SYMBOL="${RED}\n❯${RESET}"
    fi

    # Line 1: Time, User@Host, Path, Git Info
    PS1="\n"
    PS1+="${GRAY}\t${RESET} "              # Time (HH:MM:SS)
    PS1+="${PURPLE}\u@\h${RESET} "           # user@host
    PS1+="${BOLD}${YELLOW}\w${RESET}"        # Current working directory
    
    # Line 2: Arrow prompt
    PS1+="${PROMPT_SYMBOL} "
}

PROMPT_COMMAND=set_bash_prompt
