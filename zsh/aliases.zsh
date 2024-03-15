# Reload Library
alias reload='omz reload'

# Chezmoi
alias cm='chezmoi'
alias cmcd='chezmoi cd'
alias cme='chezmoi edit'
alias cma='chezmoi apply'
alias cmu='chezmoi update'

# Git
alias gs='gst'

# open conflicted files in VSCode.
alias fix='code `git diff --name-only | uniq`'

# Vim
alias vim='nvim'

## empty directory of all files and directories, including 
## hidden files
## https://unix.stackexchange.com/questions/77127/rm-rf-all-files-and-all-hidden-files-without-error
alias empty='find . -name . -o -prune -exec rm -rf -- {} +'

# programs
alias hosts='sudo $EDITOR /etc/hosts'

# List only directories
alias lsd='ls -l | grep "^d"'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# File size
alias fs="stat -f \"%z bytes\""
