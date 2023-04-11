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
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

# .NET Core
export PATH="$PATH:$HOME/.dotnet/tools"

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

# Start the X server if we're in a login shell
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi
