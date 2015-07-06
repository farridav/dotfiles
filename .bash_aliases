# My Aliases
alias gti='git'
alias semacs='sudo emacs -nw'
alias emacs='emacs -nw'
alias lwrjpg='for i in *.JPG; do mv $i ${i/%JPG/jpg} ;done'
alias replacer='for i in * ; do j=`echo $i | sed 's/find/replace/g' - ` ; mv "$i" "$j" ; done'
alias battery='acpi'
alias webperms='find . -type d -exec chmod u=rwx,g=rx,o= {} \; && find . -type f -exec chmod u=rw,g=r,o= {} \;'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'

# work aliases
alias e='. .venv/bin/activate'
alias tsr='./manage.py test --settings=rbx.settings.test'
alias cdk='cd ~/workspace/keymanager && . .venv/bin/activate'
alias cdd='cd ~/workspace/davidfarrington && . .venv/bin/activate'

export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=${PATH}:/opt/vagrant/bin
export EDITOR='emacs -nw'

parse_git_remote () {
    git ls-remote --get-url 2> /dev/null | sed s/git@github.com:/https\:\\/\\/github.com\\// | sed s/.git$//
}

RBX_REPOS='/home/david/workspace/rockabox'
ANXS_REPOS='/home/david/workspace/ANXS'

cdr () {
    if [[ -z "$1" ]]
    then
        cd $RBX_REPOS/rbx && . .venv/bin/activate
    else
        cd $RBX_REPOS/$1 && . .venv/bin/activate
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

kill_port () {
  killport='sudo fuser -k $1/tcp'
}

# Alias to clean local branches that have been merged into develop
alias gbc='git fetch -p && git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# Reset to origin of this branch
alias gr='git fetch -p && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

# Open up a compare in github with this branch and develop, ready for PR creation
alias pr='firefox $(parse_git_remote)/compare/develop...$(git rev-parse --abbrev-ref HEAD) 2> /dev/null'

# View all Pr's on this repo, in github
alias prs='xdg-open $(parse_git_remote)/pulls 2> /dev/null'

# Amend the last commit and re-push this branch
alias ga='git add -u && git commit --amend && git push origin $(git rev-parse --abbrev-ref HEAD) --force'

alias venv='virtualenv .venv && . .venv/bin/activate'

alias sync='rsync -avz --exclude .git --exclude .venv desktop:`pwd`/ `pwd`/'

new_branch () {
  git fetch -p
  git checkout develop
  git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)
  git checkout -b $1
}


alias video='totem $1 &> /dev/null'