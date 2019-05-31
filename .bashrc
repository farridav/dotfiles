#!/bin/bash

configure_history () {
    #alias hh=hstr                    # hh to be alias for hstr
    #export HSTR_CONFIG=hicolor       # get more colors
    shopt -s histappend              # append new history items to .bash_history
    export HISTCONTROL=ignorespace   # leading space hides commands from history
    export HISTFILESIZE=10000        # increase history file size (default is 500)
    export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)

    # ensure synchronization between Bash memory and history file
    #export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

    # if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
    #if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi

    # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
    #if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
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

configure_npm () {
    export PATH="$PATH:$HOME/.npm-packages/bin"
}

configure_serverless () {
    NODE_MODULES="~/.npm-packages/lib/node_modules/"
    # tabtab source for serverless package
    # uninstall by removing these lines or running `tabtab uninstall serverless`
    [ -f $NODE_MODULES/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $NODE_MODULES/serverless/node_modules/tabtab/.completions/serverless.bash

    # tabtab source for sls package
    # uninstall by removing these lines or running `tabtab uninstall sls`
    [ -f $NODE_MODULES/serverless/node_modules/tabtab/.completions/sls.bash ] && . $NODE_MODULES/serverless/node_modules/tabtab/.completions/sls.bash
}

configure_python () {
    export PYTHONIOENCODING=utf_8
    export PYTHONDONTWRITEBYTECODE=1
    export PYTHONPATH="${PYTHONPATH}:"
    export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
    export WHEELHOUSE="${HOME}/.cache/pip/wheelhouse"
    export PIP_FIND_LINKS="file://${WHEELHOUSE}/"
    export PIP_WHEEL_DIR="${WHEELHOUSE}"
}

configure_go () {
    export GOPATH=$HOME/workspace/go
    export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
}

configure_pyenv () {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PATH:$PYENV_ROOT/bin"
    eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
    . $PYENV_ROOT/completions/pyenv.bash
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

configure_shell
configure_history
configure_bash
configure_ssh_agent
configure_npm
configure_serverless
configure_python
configure_go
configure_pyenv
# configure_gcloud

export NVM_DIR="$HOME/.nvm"
export PIPENV_VERBOSITY=-1

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /home/david/workspace/prophesea/data-ingestion/node_modules/tabtab/.completions/slss.bash ] && . /home/david/workspace/prophesea/data-ingestion/node_modules/tabtab/.completions/slss.bash
