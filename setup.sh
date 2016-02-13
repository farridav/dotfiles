#!/bin/bash

delete_and_link () {
    rm -ri $2
    ln -s $PWD/$1 $2
    echo "$1 has been symlinked to $2"
}

sudo_link () {
    sudo ln -sf $PWD/$1 $2
    echo "$1 has been sudo symlinked to $2"
}

delete_and_link .bashrc ~/.bashrc
delete_and_link .bash_aliases ~/.bash_aliases
delete_and_link .gitconfig ~/.gitconfig
delete_and_link .gitignore ~/.gitignore
delete_and_link .noserc ~/.noserc
delete_and_link .tmux.conf ~/.tmux.conf
delete_and_link init.el ~/.emacs.d/init.el
delete_and_link i3  ~/.i3/
delete_and_link uzbl.conf  ~/.config/uzbl/config

sudo_link autocomplete/anxs /etc/bash_completion.d/anxs
sudo_link autocomplete/rbx /etc/bash_completion.d/rbx
sudo_link autocomplete/scoota /etc/bash_completion.d/scoota
sudo_link autocomplete/git_repos /etc/bash_completion.d/git_repos

sudo ln -sf /usr/bin/uzbl-tabbed /usr/bin/www
