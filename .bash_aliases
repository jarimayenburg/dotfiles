alias r='ranger'
alias xc='xclip -selection clipboard'

# Git aliasses
alias gs='git status'
alias ga='git add'
alias gA='git add -A'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'

# Kubect
alias k='kubectl'
complete -F __start_kubectl k

# Fix for sudo not being able to handle aliases
alias sudo='sudo '

# Vim -> Nvim
alias vim='nvim'

# Open vimrc easily
alias vimrc='vim ~/.config/nvim/init.vim'

# Dotfiles command
alias dotfiles="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME"
