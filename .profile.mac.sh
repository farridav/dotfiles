# Colour (for Mac OS)
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Autocompletion for mac
if [ -f $(brew --prefix)/etc/bash_completion ] && ! shopt -oq posix; then
    . $(brew --prefix)/etc/bash_completion
fi

# Now source our bashrc file
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
