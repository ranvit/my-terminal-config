export PATH="/Users/ranvitbommineni/go/bin:$PATH"

#export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR='subl -w'

## PYENV ##

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## END PYENV ##

alias cdsifter="cd ~/Workspace/siftershop/"
