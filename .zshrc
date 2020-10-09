autoload -U promptinit; promptinit
prompt pure

# Needed for kubectl autocomplete..?
autoload -Uz compinit
compinit

source ~/.bash_profile
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls='ls -FGA'

## cd is followed by ls
function chpwd() {
    ls
}

## Fancy History Browsing
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
setopt HIST_IGNORE_ALL_DUPS

## Kubectl Auto-Completion
source <(kubectl completion zsh)

## zsh-kubectl-prompt
autoload -U colors; colors
source $(brew ls zsh-kubectl-prompt | grep 'kubectl.zsh')
# [[ "$(kubectl config current-context)" =~ "aks-prod" ]] && color=red || color=green
RPROMPT='%{$bg[$([[ "$(kubectl config current-context)" =~ "aks-prod" ]] && echo red || echo green)]$fg[black]%}[$ZSH_KUBECTL_PROMPT]%{$reset_color%}'
# customization
zstyle ':zsh-kubectl-prompt:' separator '|'


## hook for direnv
eval "$(direnv hook zsh)"
