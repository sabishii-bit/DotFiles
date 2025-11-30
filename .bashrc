#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Full color palette
BLACK="\[\e[30m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"
WHITE="\[\e[37m\]"

BRIGHT_BLACK="\[\e[90m\]"
BRIGHT_RED="\[\e[91m\]"
BRIGHT_GREEN="\[\e[92m\]"
BRIGHT_YELLOW="\[\e[93m\]"
BRIGHT_BLUE="\[\e[94m\]"
BRIGHT_MAGENTA="\[\e[95m\]"
BRIGHT_CYAN="\[\e[96m\]"
BRIGHT_WHITE="\[\e[97m\]"

RESET="\[\e[0m\]"

# Multiline shell prompt style using unicode box-drawing characters
PS1="${CYAN}╭─(${BRIGHT_BLUE}\u@\h${CYAN})─(${BRIGHT_RED}\w${CYAN})${RESET}\n${CYAN}╰─${RESET}\$ "
