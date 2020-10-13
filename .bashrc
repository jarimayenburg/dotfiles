#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Define some XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Bash completion
source /usr/share/bash-completion/bash_completion

# Set EDITOR and VISUAL
export EDITOR='vi -c'
export VISUAL='nvim'

# Enabl bash vi-mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Kubectl completion for Bash
source <(kubectl completion bash)

# Add ~/Bin to $PATH
export PATH="$PATH:$HOME/Bin"

# Java environment variables
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$PATH:$JAVA_HOME/bin"

# Add Ruby gem bin directory to $PATH
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

# FZF
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
