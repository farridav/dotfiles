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
    fuser -k $1/tcp
}

get_date () {
    date "+%H:%M:%S"
}

curlh () {
    curl -sSL -D - $1 -o /dev/null
}

proxy_off () {
    unset no_proxy
    unset NO_PROXY

    unset all_proxy
    unset ALL_PROXY

    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
}

proxy_on () {
    export no_proxy=localhost,127.0.0.0/8,*.local
    export NO_PROXY=localhost,127.0.0.0/8,*.local

    export all_proxy=socks://127.0.0.1:8889/
    export ALL_PROXY=socks://127.0.0.1:8889/

    export http_proxy=http://127.0.0.1:8888
    export HTTP_PROXY=http://127.0.0.1:8888
    export https_proxy=http://127.0.0.1:8888
    export HTTPS_PROXY=http://127.0.0.1:8888
}

#############
# Variables #
#############

#####################
# Exports variables #
#####################

export PS1="[\[\033[32m\]\w\[\033[0m\]]\$(parse_git_branch)\n\$(get_date) \[\033[1;36m\]\[\033[1;33m\]-> \[\033[0m\]"
export EDITOR='emacs -nw'
export BROWSER=/usr/bin/firefox
export PATH="$PATH:/opt/bin:$HOME/.local/bin/"
export GPG_TTY=$(tty)
export PIPENV_VENV_IN_PROJECT=1

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
alias grab='scrot -s -e "mv $f ~/Pictures/screenshots/"'
alias enc='gpg --symmetric'
alias dec='gpg --decrypt'

# ls aliases
alias l='ls -1 --color=auto'
alias ll='ls -lah --color=auto'
alias ls='ls --color=auto'

alias docker_container_wipe='docker rm -f $(docker ps -a -q)'
alias docker_image_wipe='docker rmi -f $(docker images -q)'

alias e='if [ -d .venv ]; then . .venv/bin/activate; fi'
alias venv='python3.6 -m venv .venv'

alias clip='xsel -i -b'
alias base64='base64 -w0'

# Update system packages/distro
alias sysupdate='sudo pacman -Syy && sudo pacman -Su'
alias aur='makepkg -si'

alias setbg='feh --bg-center /home/david/Documents/wallpaper.jpg'
alias ff="firefox --new-tab "

alias kot="kotlinc $1 -include-runtime -d $1.jar && java -jar $1.jar"
alias retry="watch -cg"
alias cdm='cd /home/david/workspace/MercedesBuddy'

alias wpshuffle='feh --bg-center "$HOME/Pictures/wallpaper/$(ls -1 $HOME/Pictures/wallpaper/ | shuf -n 1)"'
alias shufflebg='wpshuffle'
alias bgshuffle='wpshuffle'
alias lambda="docker run -v "$PWD":/var/task -it lambci/lambda:build bash"
alias pipcache='pip install --download ${HOME}/.pip-packages'
alias pipinstall='pip install --no-index --find-links=file://${HOME}/.pip-packages/'

alias c='clear'

# Connect to wireless networks
alias net='nmtui'
alias trans='compton-trans -c 85'
alias dim='xrandr --output eDP-1 --brightness 0.5'
