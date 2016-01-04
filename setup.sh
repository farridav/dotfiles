#!/bin/bash

delete_and_link () {
    rm -rf $2
    ln -s $PWD/$1 $2
    echo "$1 has been symlinked to $2"
}

delete_and_link .bashrc ~/.bashrc
delete_and_link .bash_aliases ~/.bash_aliases
delete_and_link .gitconfig ~/.gitconfig
delete_and_link .gitignore ~/.gitignore
delete_and_link .noserc ~/.noserc
delete_and_link .tmux.conf ~/.tmux.conf
delete_and_link init.el ~/.emacs.d/init.el
delete_and_link uzbl.conf  ~/.config/uzbl/config

# Shortcut uzbl to www
sudo ln -sf /usr/bin/uzbl-tabbed /usr/bin/www
