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
# Lovely git log, thx @visionmedia
alias glog="git log --format='%Cgreen%h%Creset %Cblue%ad%Creset %C(cyan)%an%Creset: %s' --graph --date=short"
# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"
# open conflicted files in VSCode.
alias fix='code `git diff --name-only | uniq`'

# Vim
alias vim='nvim'

# output current git branch, echo $(curbr)
function curbr() {
  git rev-parse --abbrev-ref HEAD
}

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

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# File size
alias fs="stat -f \"%z bytes\""
