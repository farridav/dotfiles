#!/bin/bash

#############
# Variables #
#############

SCOOTA_REPOS='/home/david/workspace/scootagroup'
RBX_REPOS='/home/david/workspace/rockabox/'
ANXS_REPOS='/home/david/workspace/ANXS'

#############
# Functions #
#############

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

cds () {
    if [[ -z "$1" ]]
    then
        cd $SCOOTA_REPOS/scoota
    else
        cd $SCOOTA_REPOS/$1
    fi
    if [ -f .venv/bin/activate ]; then
	. .venv/bin/activate
    fi
}

_cds_completion() {
    COMPREPLY=()
    local cur projects
    projects=$(ls $SCOOTA_REPOS 2>/dev/null)
    _get_comp_words_by_ref cur
    COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
}
complete -F _cds_completion cds

cda () {
    if [[ -z "$1" ]]
    then
        cd $ANXS_REPOS && . .venv/bin/activate
    else
        cd $ANXS_REPOS/repos/$1 && . ../../.venv/bin/activate
    fi
}

_cda_completion() {
    COMPREPLY=()
    local cur projects
    projects=$(ls $ANXS_REPOS/repos 2>/dev/null)
    _get_comp_words_by_ref cur
    COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
}
complete -F _cda_completion cda

cdr () {
    cd $RBX_REPOS/$1
    if [ -f .venv/bin/activate ]; then
	. .venv/bin/activate
    fi
}

_cdr_completion() {
    COMPREPLY=()
    local cur projects
    projects=$(ls $RBX_REPOS 2>/dev/null)
    _get_comp_words_by_ref cur
    COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
}
complete -F _cdr_completion cdr

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed s/git@github.com:/https\:\\/\\/github.com\\// | sed s/.git$//
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
alias video='totem $1 &> /dev/null'
alias dev='tmux new-session -A -s dev'
alias grep='grep --color=auto'
alias clean='find -name *~ -delete && find -name *.pyc -delete'
alias clipboard='xclip -sel clip'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'
alias ll='ls -lah'
alias ls='ls --color=auto'
alias l='ls -CF'

# work aliases
alias e='. .venv/bin/activate'
alias tsr='./manage.py test --settings=rbx.settings.test'
alias cdk='cd ~/workspace/keymanager && . .venv/bin/activate'
alias cdd='cd ~/workspace/davidfarrington && . .venv/bin/activate'
alias cdf='cd ~/workspace/famous && . .venv/bin/activate'

# Grep for python projects
alias pygrep='grep -rn --exclude-dir .venv --exclude-dir .git --exclude *.pyc'
# global find and replace
alias greplace='grep -Irl "$1" | xargs sed -i "s/$1/$2/g"'

# View all Pr's on this repo, in github
alias prs='xdg-open $(parse_git_remote)/pulls 2> /dev/null'

# Open up a compare in github with this branch and develop, ready for PR creation
alias pr='xdg-open $(parse_git_remote)/compare/develop...$(git rev-parse --abbrev-ref HEAD) 2> /dev/null'

#####################
# Exports variables #
#####################

export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=${PATH}:/opt/vagrant/bin
export EDITOR='emacs -nw'
export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\[\033[1;36m\]$(uname -n)\[\033[1;33m\]-> \[\033[0m\]"
