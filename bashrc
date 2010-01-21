export PS1="\w \$ "             # set prompt
export EDITOR=gedit
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export JRUBY_HOME=$HOME/bin/jruby
export PATH=$JRUBY_HOME/bin:$PATH

if [ -f ~/dev/dotfiles/bash_aliases ]; then
    . ~/dev/dotfiles/bash_aliases
fi
