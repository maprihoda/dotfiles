export EDITOR=gedit


if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -f ~/dev/dotfiles/bash_aliases ]; then
    . ~/dev/dotfiles/bash_aliases
fi


function current_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (.*)/1/'
}

function parse_git_branch {
  if [ -n "`current_git_branch`" ]; then
    echo "(`current_git_branch`)"
  fi
}

#export PS1="\w \$ "
export PS1="\w \$(parse_git_branch)\$ "


export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PYTHONPATH=$HOME/dev/lib:$PYTHONPATH
export DJANGO_COLORS="nocolor"

export PATH=/usr/local/bin/rubydir/bin:$PATH

. ~/dev/version-control/git/git-completion.bash

