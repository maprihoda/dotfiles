export PS1="\w \$ "             # set prompt

export EDITOR=gedit


if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -f ~/dev/dotfiles/bash_aliases ]; then
    . ~/dev/dotfiles/bash_aliases
fi


export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONPATH=$HOME/dev/lib:$PYTHONPATH
export DJANGO_COLORS="nocolor"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

