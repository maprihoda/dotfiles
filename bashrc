# source ~/.bashrc

export EDITOR=subl


if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -f ~/Dropbox/Documents/dev/dotfiles/bash_aliases ]; then
    . ~/Dropbox/Documents/dev/dotfiles/bash_aliases
fi


export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval "$(rbenv init -)"


export PYTHONSTARTUP="$HOME/.pythonrc.py"


# export PS1="\w \$ "
export PS1="\w \$(parse_git_branch)\$ "

function current_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (.*)/1/'
}

function parse_git_branch {
  if [ -n "`current_git_branch`" ]; then
    echo "(`current_git_branch`)"
  fi
}

. ~/Dropbox/Documents/dev/git/git-completion.bash
