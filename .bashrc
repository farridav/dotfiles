#!/bin/bash

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
    # Bring in our aliases and autocompletion

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    fi

    if [ -f ~/.bash_completion ] && ! shopt -oq posix; then
        . ~/.bash_completion
    fi
}

configure_shell () {
    # make less more friendly for non-text input files
    # Adjust window cols and rows on each command

    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
    shopt -s checkwinsize
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

configure_gcloud () {
    export CLOUD_SDK_ROOT="/opt/google-cloud-sdk"
    export GAE_SDK_ROOT="${CLOUD_SDK_ROOT}/platform/google_appengine"
    export PYTHONPATH="${GAE_SDK_ROOT}:${PYTHONPATH}"

    # * OPTIONAL STEP *
    # If you wish to import all Python modules, you may iterate in the directory
    # tree and import each module.
    #
    # * WARNING *
    # Some modules have two or more versions available (Ex. django), so the loop
    # will import always its latest version.
    #for module in ${GAE_SDK_ROOT}/lib/*; do
    #  if [ -r ${module} ]; then
    #    PYTHONPATH=${module}:${PYTHONPATH}
    #  fi
    #done
    #unset module

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/opt/google-cloud-sdk/path.bash.inc' ]; then
        source '/opt/google-cloud-sdk/path.bash.inc';
    fi

    # The next line enables shell command completion for gcloud.
    if [ -f '/opt/google-cloud-sdk/completion.bash.inc' ]; then
        source '/opt/google-cloud-sdk/completion.bash.inc';
    fi
}


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

configure_shell
configure_history
configure_bash
configure_ssh_agent
configure_gcloud

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/david/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /home/david/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/david/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /home/david/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
