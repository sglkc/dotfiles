#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias l='ls'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# dir up aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .....='cd ../../..'
alias ......='cd ../../..'

alias lzd='lazydocker'
alias lg='lazygit'
alias e='exit'
alias ssh='TERM="xterm-256color" ssh'
alias live='budo --wg "**/*.{html,css,js,mjs}" --live'
alias rm='trash -v --'
alias rm!='rm'

# auto cd if using directory
shopt -s autocd

# fnm node version manager
FNM_PATH="/home/seya/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# starship for prompt
eval "$(starship init bash)"

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                   # hh to be alias for hstr
export HSTR_CONFIG=hicolor      # get more colors
shopt -s histappend             # append new history items to .bash_history
export HISTCONTROL=ignoreboth   # leading space hides commands from history
export HISTFILESIZE=10000       # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE} # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
  { READLINE_LINE="$({ </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&-)"; } 3>&1
  READLINE_POINT=${#READLINE_LINE}
}
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

# pnpm
alias npm=pnpm
export PNPM_HOME="/home/seya/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# command not found detection, SLOW!
# if [ -a /usr/share/doc/pkgfile/command-not-found.bash ]
#   source /usr/share/doc/pkgfile/command-not-found.bash
# fi

# add local bin for zoxide and more...
LOCAL_BIN="/home/seya/.local/bin"
if [ -d "$LOCAL_BIN" ]; then
  export PATH="$LOCAL_BIN:$PATH"
fi

# zoxide for cd replacement
eval "$(zoxide init bash)"
alias cd=z

# fix locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# unified cache location with windows
CACHE_DIR="/mnt/storage/.cache"
export UV_CACHE_DIR="$CACHE_DIR/uv"
export GO_PATH="$CACHE_DIR/go"
export COMPOSER_HOME="$CACHE_DIR/composer"
