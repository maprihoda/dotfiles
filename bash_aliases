# source ~/.bashrc

alias h='history'
alias l='ls'
alias ll='ls -alh'
alias la='ls -a'
alias lr='ls -R'
alias ld='ls -ld'
alias pt='pstree | less'
alias f='~/Dropbox/dev/scripts/find.py'

# Ruby
alias r='rails'
alias rs='bundle exec rails s -b 127.0.0.1'
alias ri='PAGER=/usr/bin/less ri'
alias recreate='bundle exec rake db:recreate db:test:prepare'
alias migrate='bundle exec rake db:migrate'
alias rlang='less -I ~/Dropbox/dev/ruby/lang/LANG.rb'
alias rubydoc='cd ~/Dropbox/dev/ruby; find . -name "*.rb" -print0 | xargs -0 cat | less'
alias railsdoc='cd ~/Dropbox/dev/rails; find . -name "*.rb" -print0 | xargs -0 cat | less'

# Javascript
alias jlang='less -I ~/Dropbox/dev/javascript/lang/LANG.js'

# Python
alias plang='less -I ~/Dropbox/dev/python/LANG.py'

# Google App Engine
alias dev_appserver.py='python ~/lib/google_appengine/dev_appserver.py'
alias appcfg.py='python ~/lib/google_appengine/appcfg.py'

# Elastic search
alias es='~/bin/elasticsearch/bin/elasticsearch -f'

# Git
alias gitalias='git config --list | grep alias'
alias gitfiles='git diff --name-status'
