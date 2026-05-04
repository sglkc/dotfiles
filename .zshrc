# ------------------------------------------------------------------------------
# Interactive shell configuration, aliases, and tool initializations
# ------------------------------------------------------------------------------

if [[ -n "$GIT_PAGER" && "$GIT_PAGER" == "cat" && "$TERM_PROGRAM" == "vscode" ]]; then
  return
fi

[ -s "/usr/share/cachyos-zsh-config/cachyos-config.zsh" ] && \. /usr/share/cachyos-zsh-config/cachyos-config.zsh

# disable autocorrect
unsetopt correct_all

# auto cd if using directory
setopt autocd

# ------------------------------------------------------------------------------
# History Config
# ------------------------------------------------------------------------------
setopt APPEND_HISTORY           # append new history items to .zsh_history
setopt HIST_IGNORE_SPACE        # leading space hides commands from history
setopt HIST_IGNORE_DUPS         # ignore duplicate commands
export HISTFILE=~/.zsh_history
export HISTSIZE=10000           # increase history size (default is 500)
export SAVEHIST=10000           # increase history file size (default is 500)

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias l='ls'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# dir up aliases
alias .='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias .....='cd ../../..'
alias ......='cd ../../..'

alias lg='lazygit'
alias e='exit'
alias venv='uv venv --allow-existing && source .venv/bin/activate'

# safe delete
if (( $+commands[trash] )); then
  alias rm='trash -v --'
  alias rm!='command rm'
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh="TERM=xterm-256color ssh"
  alias less="TERM=xterm-256color less" # https://github.com/gwsw/less/issues/710
fi

# nodejs live web server
(( $+commands[budo] )) && alias live='budo --host localhost --wg "**/*.{html,css,js,mjs}" --live'

# ------------------------------------------------------------------------------
# Keybindings
# ------------------------------------------------------------------------------
# ctrl backspace delete
bindkey '^H' backward-kill-word

# ------------------------------------------------------------------------------
# Tool Initializations & Completions
# ------------------------------------------------------------------------------

if (( $+commands[fnm] )); then
  eval "$(fnm env)"
fi

# if (( $+commands[npm] )); then
#   eval "$(npm completion)" # slow
# fi

# if (( $+commands[pnpm] )); then
#   eval "$(pnpm completion zsh)" # slow
# fi

# moon
# if (( $+commands[moon] )); then
#   eval "$(moon completions --shell zsh)"
# fi

# fzf completions (Uncomment when needed)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# bindkey -s '^f' '~/.fzf.rg.zsh\n'

# zoxide for cd replacement, always put at the end!
if (( $+commands[zoxide] )); then
  export _ZO_DOCTOR=0
  eval "$(zoxide init zsh)"
  alias cd=z
fi
