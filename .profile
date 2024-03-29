alias ls='ls --color=auto'

# Define some XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Set EDITOR and VISUAL
export VISUAL='nvim'
export EDITOR="$VISUAL"

# Add ~/Bin to $PATH
export PATH="$PATH:$HOME/.local/bin"

# Add Cargo to $PATH
export PATH="$PATH:$HOME/.cargo/bin"

# Java environment variables
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$PATH:$JAVA_HOME/bin"

# Add Ruby gem bin directory to $PATH
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"

# .NET Core
export PATH="$PATH:$HOME/.dotnet/tools"

# Node module binaries
export PATH="$PATH:node_modules/.bin"

# === Improvements to history file ===

# Increase Bash history file size
export HISTSIZE=10000
export HISTFILESIZE=10000

# Store Bash history immediately
export PROMPT_COMMAND='history -a'

# Ignore duplicates
export HISTCONTROL=ignoredups

# Ignore some commands
export HISTIGNORE="ls:ps:history"

export GPG_TTY=$(tty)

export GOPATH="$HOME/.go"

source "$HOME/.cargo/env"

export PATH="$PATH:$(yarn global bin)"

# Add ~/.local/bin to PATH
export PATH="$PATH:$HOME/.local/bin"

# Add Go folders to PATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Lazy load NVM
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  alias nvm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && nvm'
  alias node='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && node'
  alias npm='unalias nvm node npm && . "$NVM_DIR"/nvm.sh && npm'
fi

# Load the .env file, which contains environment variables
[ -f "$HOME/.env" ] && source "$HOME/.env"

# Haskell ghcup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Kubectl Krew
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"

# Start the X server if we're in a login shell
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
