#!/bin/bash

#############
# Variables #
#############

#####################
# Exports variables #
#####################

export EDITOR='emacs'
export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\$(get_date) \[\033[1;36m\]\[\033[1;33m\]-> \[\033[0m\]"

#############
# Functions #
#############

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed "s/git@github.com:/https:\/\/github.com\//" | sed s/.git$//
}

get_date () {
    date "+%H:%M:%S"
}

all () {
    cmd="$*"

    for i in *; do
        echo ""
        echo "'$cmd' on $i"
        pushd $i >/dev/null
        bash -c $cmd 2> /dev/null || true
        popd >/dev/null
    done;
}

###########
# Aliases #
###########
alias semacs='sudo emacs -nw'
alias emacs='emacs -nw'
alias lwrjpg='for i in *.JPG; do mv $i ${i/%JPG/jpg} ;done'
alias replacer='for i in * ; do j=`echo $i | sed 's/find/replace/g' - ` ; mv "$i" "$j" ; done'
alias webperms='find . -type d -exec chmod u=rwx,g=rx,o= {} \; && find . -type f -exec chmod u=rw,g=r,o= {} \;'
alias venv='virtualenv .venv && . .venv/bin/activate'
alias sync='rsync -avz --exclude .git --exclude .venv ultra:`pwd`/ `pwd`/'
alias grep='grep --color=auto'
alias clean='find . -name "*~" -delete && find . -name "*.pyc" -delete'
alias terraform_graph='terraform graph | dot -Tpng > /tmp/graph.png && xdg-open /tmp/graph.png'

# ls aliases
alias l='ls -1'
alias ll='ls -lah'
alias ls='ls'

# work aliases
alias e='if [ -d .venv ]; then . .venv/bin/activate; fi'

# Grep for python projects
alias pygrep='grep -rn --exclude-dir .venv --exclude-dir .git --exclude *.pyc'

# global find and replace
alias greplace='grep -Irl "$1" | xargs sed -i "s/$1/$2/g"'

alias docker_container_wipe='docker rm -f $(docker ps -a -q)'
alias docker_image_wipe='docker rmi -f $(docker images -q)'

alias flip='xrandr --output HDMI1 --auto --left-of eDP1 --rotate normal'

alias pickup='emacs -nw $(git wip)'
