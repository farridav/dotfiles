# My Aliases
alias semacs='sudo emacs -nw'
alias emacs='emacs -nw'
alias lwrjpg='for i in *.JPG; do mv $i ${i/%JPG/jpg} ;done'
alias replacer='for i in * ; do j=`echo $i | sed 's/find/replace/g' - ` ; mv "$i" "$j" ; done'
alias webperms='find . -type d -exec chmod u=rwx,g=rx,o= {} \; && find . -type f -exec chmod u=rw,g=r,o= {} \;'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'

# work aliases
alias e='. .venv/bin/activate'
alias tsr='./manage.py test --settings=rbx.settings.test'
alias cdk='cd ~/workspace/keymanager && . .venv/bin/activate'
alias cdd='cd ~/workspace/davidfarrington && . .venv/bin/activate'
alias cdf='cd ~/workspace/famous && . .venv/bin/activate'

# Grep for python projects
alias pygrep='grep -rn --exclude-dir .venv --exclude-dir .git --exclude *.pyc'

export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=${PATH}:/opt/vagrant/bin
export EDITOR='emacs -nw'

SCOOTA_REPOS='/home/david/workspace/scootagroup'
RBX_REPOS='/home/david/workspace/rockabox/'
ANXS_REPOS='/home/david/workspace/ANXS'

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

alias venv='virtualenv .venv && . .venv/bin/activate'
alias sync='rsync -avz --exclude .git --exclude .venv desktop:`pwd`/ `pwd`/'
alias video='totem $1 &> /dev/null'

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed s/git@github.com:/https\:\\/\\/github.com\\// | sed s/.git$//
}

# View all Pr's on this repo, in github
alias prs='xdg-open $(parse_git_remote)/pulls 2> /dev/null'

# Open up a compare in github with this branch and develop, ready for PR creation
alias pr='firefox $(parse_git_remote)/compare/develop...$(git rev-parse --abbrev-ref HEAD) 2> /dev/null'

