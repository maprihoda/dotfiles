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
alias railsway='less -I ~/dev/ror/railsway'
alias awdr='less -I ~/dev/ror/awdr'
alias railsaction='less -I ~/dev/ror/railsaction'
alias lr3='less -I ~/dev/ror/lr3'
alias rspec-2='less -I ~/dev/ror/testing/RSPEC-2.rb'
alias capybara='less -I ~/dev/ror/testing/CAPYBARA.rb'
alias factory_girl='less -I ~/dev/ror/testing/FACTORY-GIRL.rb'
alias rs='r s -b 127.0.0.1'
alias ri='PAGER=/usr/bin/less ri'

# alias es='~/bin/elasticsearch/bin/elasticsearch -f'

# Javascript
alias jlang='less -I ~/dev/UI/javascript/LANG.js'

# Python
alias plang='less -I ~/dev/python/LANG.py'

# PHP
alias dibi='less -I /home/ardentr/dev/php/dibi/DIBI.php'


# Google App Engine
alias dev_appserver.py='python2.5 ~/lib/google_appengine/dev_appserver.py'
# need this because of the ssl module
alias appcfg.py='python ~/lib/google_appengine/appcfg.py'

# Git
alias gitalias='git config --list | grep alias'

