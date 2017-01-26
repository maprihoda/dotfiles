# source ~/.bashrc

alias h='history'
alias l='ls'
alias ll='ls -alh'
alias la='ls -a'
alias lr='ls -R'
alias ld='ls -ld'

# Ruby
alias r='rails'
alias rs='bundle exec rails s -b 127.0.0.1'
alias ri='PAGER=/usr/bin/less ri'
alias migrate='bundle exec rake db:migrate'
alias be="bundle exec "
alias rclean="bundle exec rake log:clear tmp:clear"
alias irb="irb --noecho"

# Elastic search
alias es='~/bin/elasticsearch/bin/elasticsearch'
alias kibana='~/bin/kibana/bin/kibana'

# Git
alias gitalias='git config --list | grep alias'

# PHP
alias phpserve='php -S localhost:8000'
