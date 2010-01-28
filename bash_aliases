alias p='python'
alias h='history'

alias l='ls --file-type'
alias ll='ls -alh --file-type'
alias la='ls -a --file-type'
alias lr='ls -R --file-type'
alias ld='ls -ld --file-type'

alias r='cd; cd dev/ruby'
alias web='cd; cd dev/webapps'

alias pt='pstree | less'

#alias ri='clear; ri -f ansi --no-pager -i'	# works with Ruby 1.9
alias ri='clear; ri -f ansi --no-pager'		# works with Ruby 1.8

alias rlang='less dev/ruby/LANG.rb'
alias plang='less dev/python/LANG.py'

alias gitalias='git config --list | grep alias'
