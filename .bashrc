#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash completion
source /usr/share/bash-completion/bash_completion

# Kubectl completion for Bash
source <(kubectl completion bash)

# Enabl bash vi-mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Always expand aliases (also in non-interactive shells)
shopt -s expand_aliases

# FZF
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

source ~/.profile
