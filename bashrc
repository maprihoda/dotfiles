# source ~/.bashrc

export EDITOR="subl -w"

export PS1="\w \$(parse_git_branch)\$ "

current_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (.*)/1/'
}

parse_git_branch () {
  if [ -n "`current_git_branch`" ]; then
    echo "(`current_git_branch`)"
  fi
}

alias h='history'
alias l='ls'
alias ll='ls -alh'
alias la='ls -a'
alias lr='ls -R'
alias ld='ls -ld'
alias gitalias='git config --list | grep alias'
alias adminer='cd ~/Dropbox/dev/databases; php -S localhost:8000/adminer.php'
alias es='~/bin/elasticsearch/bin/elasticsearch'
alias kibana='~/bin/kibana/bin/kibana'

if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi



source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
