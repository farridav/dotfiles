configure_history () {
    # Dont insert duplicates, or commands beggining with space
    # configure history size
    # append to the history file, don't overwrite it

    export HISTCONTROL=ignoredups:ignorespace
    export HISTSIZE=1000000
    export HISTFILESIZE=2000000
    shopt -s histappend
}

configure_bash () {
    # Bring in ouraliases
    # Activate autocompletion

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
}

configure_shell () {
    # make less more friendly for non-text input files
    # Adjust window cols and rows on each commandw

    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    shopt -s checkwinsize
}

configure_nvm () {
    # Start up NVM

    export NVM_DIR="~/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

configure_ssh_agent () {
    # Start up our ssh-agent and add our identity

    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi

    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

    ssh-add -l | grep "The agent has no identities" && ssh-add
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

configure_shell
configure_history
configure_bash
configure_nvm
configure_ssh_agent

export PATH=$PATH:/opt/google_appengine/

# The next line updates PATH for the Google Cloud SDK.
source '/opt/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/opt/google-cloud-sdk/completion.bash.inc'
