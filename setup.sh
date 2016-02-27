#!/bin/bash

delete_and_link () {
    if [[ ! -L $2 ]]; then
        rm -r $2
        ln -s $1 $2
        echo "$1 has been symlinked to $2"
    fi
}

sudo_link () {
    if [[ ! -L $2 ]]; then
        sudo ln -s $1 $2
        echo "$1 has been sudo symlinked to $2"
    fi
}

delete_and_link $PWD/.bashrc        $HOME/.bashrc
delete_and_link $PWD/.bash_aliases  $HOME/.bash_aliases
delete_and_link $PWD/.gitconfig     $HOME/.gitconfig
delete_and_link $PWD/.gitignore     $HOME/.gitignore
delete_and_link $PWD/.noserc        $HOME/.noserc
delete_and_link $PWD/.tmux.conf     $HOME/.tmux.conf
delete_and_link $PWD/.i3            $HOME/.i3
delete_and_link $PWD/init.el        $HOME/.emacs.d/init.el
delete_and_link $PWD/uzbl.conf      $HOME/.config/uzbl/config

sudo_link $PWD/autocomplete/anxs      /etc/bash_completion.d/anxs
sudo_link $PWD/autocomplete/rbx       /etc/bash_completion.d/rbx
sudo_link $PWD/autocomplete/scoota    /etc/bash_completion.d/scoota
sudo_link $PWD/autocomplete/git_repos /etc/bash_completion.d/git_repos
sudo_link $PWD/autocomplete/git_repos /etc/bash_completion.d/git_repos
sudo_link /usr/bin/uzbl-tabbed        /usr/bin/www
