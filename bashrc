export PS1="\w \$ "             # set prompt
export EDITOR=gedit
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export JRUBY_HOME=$HOME/bin/jruby
export PATH=$PATH:$JRUBY_HOME/bin
export GEM_HOME=/usr/lib/ruby/gems/1.8

if [ -f ~/dev/dotfiles/bash_aliases ]; then
    . ~/dev/dotfiles/bash_aliases
fi
