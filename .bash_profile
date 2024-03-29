export PATH="/Users/ranvitbommineni/go/bin:$PATH"

#export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR='subl -w'

## PYENV ##

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv virtualenv-init -)"

## END PYENV ##

alias k="kubectl"
alias cdsifter="cd ~/Workspace/siftershop/"
alias docker-ELK="docker run -dit  -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --network elasticsearch-kibana --name elasticsearch elasticsearch:7.7.0; docker run -dit --name kibana --publish 5601:5601 --network elasticsearch-kibana --env "ELASTICSEARCH_HOST:http://elasticsearch:9200" kibana:7.7.0"
alias gitnuke="git fetch --all; git reset --hard origin/master; git pull origin master"

# https://github.com/sindresorhus/do-not-disturb-cli
alias dndon='dnd on && defaults write com.apple.dock autohide -bool false && killall Dock'
alias dndoff='dnd off && defaults write com.apple.dock autohide -bool true && killall Dock'

alias notify='osascript -e "display notification \"FINISHED\" with title \"Title\" sound name \"\""'

# initialize logstash timestamp configmap
function lg-start () {
   kubectl delete cm sifter-logstash-timestamp;
   kubectl create cm sifter-logstash-timestamp --from-literal=START_TIME=$(date '+%Y-%m-%d--%H-%M');
   kubectl describe cm sifter-logstash-timestamp
}
