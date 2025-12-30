#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Ubuntu default bashrc
[ -f /etc/bash.bashrc ] && source /etc/bash.bashrc

alias l='ls'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# dir up aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .....='cd ../../..'
alias ......='cd ../../..'

alias python='python3'
alias lg='lazygit'
alias e='exit'

# safe delete
if [ -x "$(command -v trash)" ]; then
  alias rm='trash -v --'
  alias rm!='rm'
fi

# nodejs live web server
[ -x "$(command -v budo)" ] && alias live='budo --wg "**/*.{html,css,js,mjs}" --live'

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh="TERM=xterm-256color ssh"
fi

if [[ -x "$(command -v fcitx5)" ]]; then
  # export GTK_IM_MODULE=fcitx
  # export QT_IM_MODULE=fcitx
  export XMODIFIERS=@im=fcitx
  export SDL_IM_MODULE=fcitx
  export INPUT_METHOD=fcitx
  export GLFW_IM_MODULE=ibus
fi

# auto cd if using directory
shopt -s autocd

# fnm node version manager
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

# starship for prompt
eval "$(starship init bash)"

# history config
shopt -s histappend             # append new history items to .bash_history
export HISTCONTROL=ignoreboth   # leading space hides commands from history
export HISTFILESIZE=10000       # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE} # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# fzf
export FZF_COMPLETION_TRIGGER="!"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
bind -x '"\C-f": "~/.fzf.rg.bash"'

# ctrl backspace delete
bind '"\C-H": shell-backward-kill-word'

# add local bin for zoxide and more...
LOCAL_BIN="$HOME/.local/bin"
[[ -d "$LOCAL_BIN" ]] && export PATH="$LOCAL_BIN:$PATH"

# unified package managers location
PACKAGE_STORE="$HOME/.cache/packages"
# Ensure exists and is owned by the current user
if [[ ! -d "$PACKAGE_STORE" ]]; then
  echo 'Creating package managers cache directory'
  sudo mkdir -p "$PACKAGE_STORE"
  sudo chown "$USER":"$USER" "$PACKAGE_STORE"
fi

if [[ -x "$(command -v npm)" ]]; then
  export NPM_HOME="$PACKAGE_STORE/npm"
  export PATH="$PATH:$NPM_HOME/bin"
  # eval "$(npm completion)" # slow
fi

if [[ -x "$(command -v pnpm)" ]]; then
  export PNPM_HOME="$PACKAGE_STORE/pnpm"
  export PATH="$PATH:$PNPM_HOME"
  # eval "$(pnpm completion bash)" # slow
fi

# TODO: cache and tool dir
if [[ -x "$(command -v uv)" ]]; then
  export UV_HOME="$PACKAGE_STORE/uv"
  export UV_CACHE_DIR="$UV_HOME/cache"
  export UV_TOOL_BIN_DIR="$UV_HOME/bin"
  export UV_TOOL_DIR="$UV_HOME/tools"
  export UV_PYTHON_BIN_DIR="$UV_HOME/python/bin"
  export UV_PYTHON_INSTALL_DIR="$UV_HOME/python"
  export UV_PYTHON_CACHE_DIR="$UV_HOME/python/cache"
  export UV_PYTHON_INSTALL_BIN=1
  export PATH="$PATH:$UV_TOOL_BIN_DIR:$UV_PYTHON_BIN_DIR"
fi

# go version manager
[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"

if [[ -x "$(command -v go)" ]]; then
  export GOPATH="$PACKAGE_STORE/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# php version manager
[ -s "${HOME}/.phpbrew/bashrc" ] && \. "${HOME}/.phpbrew/bashrc"

if [[ -x "$(command -v composer)" ]]; then
  export COMPOSER_HOME="$PACKAGE_STORE/composer"
  export PATH="$PATH:$COMPOSER_HOME/vendor/bin"
fi

# dotnet
DOTNET_DIR="$HOME/.dotnet/tools"
[[ -d "$DOTNET_DIR" ]] && export PATH="$PATH:$DOTNET_DIR"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# android studio from apt
export ANDROID_HOME="/usr/lib/android-sdk"
if [ -d "$ANDROID_HOME" ]; then
  export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$PATH"
fi

# moon
if [[ -x "$(command -v moon)" ]]; then
  eval "$(moon completions)"
fi

# venv shortcut
alias venv='source .venv/bin/activate'

# zoxide for cd replacement, always put at the end!
if [[ -x "$(command -v zoxide)" ]]; then
  eval "$(zoxide init bash)"
  alias cd=z
  export _ZO_DOCTOR=0
fi
