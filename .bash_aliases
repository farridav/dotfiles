#!/bin/bash

#############
# Variables #
#############

#############
# Functions #
#############

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed s/git@github.com:/https\:\\/\\/github.com\\// | sed s/.git$//
}

pr () {
    # Open up a compare in github with this branch and master, ready for PR creation
    # e.g `pr master`

    address="$(parse_git_remote)/compare/$1...$(git rev-parse --abbrev-ref HEAD)"
    xdg-open $address 2> /dev/null
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
alias clean='find -name *~ -delete && find -name *.pyc -delete'
alias clipboard='xclip -sel clip'
alias terraform_graph='terraform graph | dot -Tpng > /tmp/graph.png && xdg-open /tmp/graph.png'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'

# work aliases
alias e='if [ -d .venv ]; then . .venv/bin/activate; fi'
alias tsr='./manage.py test --settings=rbx.settings.test'

# Grep for python projects
alias pygrep='grep -rn --exclude-dir .venv --exclude-dir .git --exclude *.pyc'

# global find and replace
alias greplace='grep -Irl "$1" | xargs sed -i "s/$1/$2/g"'

# View all Pr's on this repo, in github
alias prs='xdg-open $(parse_git_remote)/pulls 2> /dev/null'

alias flake8='flake8 . --exclude .venv --exclude migrations'
alias docker_container_wipe='docker rm $(docker ps -a -q)'
alias docker_image_wipe='docker rmi $(docker images -q)'

#####################
# Exports variables #
#####################

export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=${PATH}:/opt/vagrant/bin
export EDITOR='emacs -nw'
export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\[\033[1;36m\]$(uname -n)\[\033[1;33m\]-> \[\033[0m\]"
alias flip='xrandr --output HDMI1 --auto --left-of eDP1 --rotate normal'
