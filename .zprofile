# ------------------------------------------------------------------------------
# Environment variables and PATH configuration
# ------------------------------------------------------------------------------

export EDITOR=$(which vim)

# Local bin
LOCAL_BIN="$HOME/.local/bin"
[[ -d "$LOCAL_BIN" ]] && export PATH="$LOCAL_BIN:$PATH"

# Unified package managers location
export PACKAGE_STORE="$HOME/.local/share/packages"
if [[ ! -d "$PACKAGE_STORE" ]]; then
  echo 'Creating package managers cache directory'
  mkdir -p "$PACKAGE_STORE"
fi

# proto version manager
export PROTO_HOME="$HOME/.proto"
[[ -d "$PROTO_HOME" ]] && export PATH="$PROTO_HOME/bin:$PATH"

# Node.js
FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi

if (( $+commands[npm] )); then
  export NPM_HOME="$PACKAGE_STORE/npm"
  export PATH="$PATH:$NPM_HOME/bin"
fi

if (( $+commands[pnpm] )); then
  export PNPM_HOME="$PACKAGE_STORE/pnpm"
  export PATH="$PATH:$PNPM_HOME"
fi

# uv
if (( $+commands[uv] )); then
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
# [[ -s "${HOME}/.g/env" ]] && \. "${HOME}/.g/env"

if (( $+commands[go] )); then
  export GOPATH="$PACKAGE_STORE/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# php version manager
[[ -s "${HOME}/.phpbrew/bashrc" ]] && \. "${HOME}/.phpbrew/bashrc"

if (( $+commands[composer] )); then
  export COMPOSER_HOME="$PACKAGE_STORE/composer"
  export PATH="$PATH:$COMPOSER_HOME/vendor/bin"
fi

# dotnet
DOTNET_DIR="$HOME/.dotnet/tools"
[[ -d "$DOTNET_DIR" ]] && export PATH="$PATH:$DOTNET_DIR"

# android studio from apt
export ANDROID_HOME="/usr/lib/android-sdk"
[[ -d "$ANDROID_HOME" ]] && export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$PATH"

# rustup for rust
[[ -s "$HOME/.cargo/env" ]] && \. "$HOME/.cargo/env"

# # fzf environment options (Uncomment when needed)
# export FZF_COMPLETION_TRIGGER="!"
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
# --color=selected-bg:#45475a \
# --color=border:#313244,label:#cdd6f4"
