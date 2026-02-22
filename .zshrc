source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lah='ls -lah'

alias ..='cd ..'
alias ~='cd ~'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gpl='git pull'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gss='git stash show -p'

alias dc='docker compose'
alias dcb='docker compose build'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dl='docker logs -f'
alias dps='docker ps'
