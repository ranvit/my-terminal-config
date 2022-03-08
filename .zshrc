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

# custom color based on context
setopt extendedglob
declare -A configcolors
configcolors=('aks-dev' green 'aks-stage' yellow 'aks-prod' red '*^(dev|stage|prod)' white)
# RPROMPT='%{$bg[$(echo ${configcolors[(k)$(echo "$ZSH_KUBECTL_CONTEXT")]})]$fg[black]%}[$ZSH_KUBECTL_PROMPT]%{$reset_color%}'

function right_prompt() {
    local color=${configcolors[(k)$(echo "$ZSH_KUBECTL_CONTEXT")]}
    echo "%{$bg[$color]$fg[black]%}[$ZSH_KUBECTL_PROMPT]%{$reset_color%}"
}

RPROMPT='$(right_prompt)'

# further customization
zstyle ':zsh-kubectl-prompt:' separator '|'
## END of zsh-kubectl-prompt ##

## hook for direnv
eval "$(direnv hook zsh)"

## ZSH Autocomplete Suggestion (might be sucky)
setopt correct

## NVM stuff
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
