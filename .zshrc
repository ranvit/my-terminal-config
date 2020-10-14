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

## START of zsh-kubectl-prompt ##
autoload -U colors; colors
source $(brew ls zsh-kubectl-prompt | grep 'kubectl.zsh')
# [[ "$(kubectl config current-context)" =~ "aks-prod" ]] && color=red || color=green

# custom color based on context
setopt extendedglob
declare -A configcolors
configcolors=('aks-dev' green 'aks-stage' yellow 'aks-prod' red '*^(dev|stage|prod)' white)
RPROMPT='%{$bg[$(echo ${configcolors[(k)$(echo "$(kubectl config current-context)")]})]$fg[black]%}[$ZSH_KUBECTL_PROMPT]%{$reset_color%}'

# further customization
zstyle ':zsh-kubectl-prompt:' separator '|'
## END of zsh-kubectl-prompt ##

## hook for direnv
eval "$(direnv hook zsh)"
