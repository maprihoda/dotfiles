export PS1="\w \$ "             # set prompt
export EDITOR=gedit

if [ -f ~/dev/dotfiles/bash_aliases ]; then
    . ~/dev/dotfiles/bash_aliases
fi
