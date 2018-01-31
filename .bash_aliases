#!/bin/bash

#############
# Functions #
#############

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed "s/git@github.com:/https:\/\/github.com\//" | sed s/.git$//
}

kill_port () {
    lsof -i tcp:$1
    lsof -t -i tcp:$1 | xargs kill -9
}

get_date () {
    date "+%H:%M:%S"
}

screen () {
    xrandr --output eDP-1 --brightness $1
}

curlh () {
    curl -sSL -D - $1 -o /dev/null
}

#############
# Variables #
#############

#####################
# Exports variables #
#####################

export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\$(get_date) \[\033[1;36m\]\[\033[1;33m\]-> \[\033[0m\]"
export PYTHONIOENCODING=utf_8
export PYTHONDONTWRITEBYTECODE=1
export EDITOR='emacs -nw'
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export GOPATH=$HOME/workspace/go
export PATH=$PATH:/usr/local/go/bin:/opt/bin:$GOPATH/bin

###########
# Aliases #
###########
alias semacs='sudo emacs -nw'
alias emacs='emacs -nw'
alias lwrjpg='for i in *.JPG; do mv $i ${i/%JPG/jpg} ;done'
alias replacer='for i in * ; do j=`echo $i | sed 's/find/replace/g' - ` ; mv "$i" "$j" ; done'
alias webperms='find . -type d -exec chmod u=rwx,g=rx,o= {} \; && find . -type f -exec chmod u=rw,g=r,o= {} \;'
alias sync='rsync -avz --exclude .git --exclude .venv ultra:`pwd`/ `pwd`/'
alias clean='find . -name "*~" -delete && find . -name "*.pyc" -delete'
alias terraform_graph='terraform graph | dot -Tpng > /tmp/graph.png && xdg-open /tmp/graph.png'
alias flake='flake8 --format "%(path)s:%(row)d" | xargs charm'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'

# work aliases
alias e='if [ -d .venv ]; then . .venv/bin/activate; fi'

alias docker_container_wipe='docker rm -f $(docker ps -a -q)'
alias docker_image_wipe='docker rmi -f $(docker images -q)'

alias venv2='virtualenv .venv -p $(which python2.7) && . .venv/bin/activate'
alias venv='virtualenv .venv -p $(which python3.6) && . .venv/bin/activate'

alias clip='xsel --clipboard'
alias base64='base64 -w0'
