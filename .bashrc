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

# Setup Python to use pyenv global
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
