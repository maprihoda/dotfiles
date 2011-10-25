# source ~/.bashrc

alias h='history'
alias l='ls'
alias ll='ls -alh'
alias la='ls -a'
alias lr='ls -R'
alias ld='ls -ld'
alias pt='pstree | less'
alias f='~/dev/scripts/find.py'

# Ruby
alias r='rails'
alias rlang='less -I ~/dev/ruby/LANG.rb'
alias railsway='less -I ~/libri/ror/railsway'
alias rspec-2='less -I ~/dev/ruby/testing/RSPEC-2.rb'
alias rs='r s -b localhost'
alias ri='PAGER=/usr/bin/less ri'

alias es='~/bin/elasticsearch/bin/elasticsearch -f'

# Javascript
alias jlang='less -I ~/dev/javascript/LANG.js'

# Python
alias plang='less -I ~/dev/python/LANG.py'

# Google App Engine
alias dev_appserver.py='python2.5 ~/lib/google_appengine/dev_appserver.py'
# need this because of the ssl module
alias appcfg.py='python ~/lib/google_appengine/appcfg.py'

# Git
alias gitalias='git config --list | grep alias'

