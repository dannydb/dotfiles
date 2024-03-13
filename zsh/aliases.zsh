# Reload Library
alias reload='source ~/.zshrc'

# Show/hide hidden files in Finder
alias showhidden="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hidehidden="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

alias sleepstate="ioreg -n IODisplayWrangler | grep -i IOPowerManagement | perl -pe 's/^.*DevicePowerState\"=([0-9]+).*$/\1/'"

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
alias hosts='sudo $EDITOR /etc/hosts'   # yes I occasionally 127.0.0.1 twitter.com ;)

# List only directories
alias lsd='ls -l | grep "^d"'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
# alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# File size
alias fs="stat -f \"%z bytes\""

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Install project requirements
alias installreq="pip install -r requirements.txt; npm install; fab update"

# Open a new iTerm tab with panes for dev server and fab/git commands
alias tab="osascript ~/Projects/dotfiles/applescript/iterm_project_tab.scpt"

# Open a new iTerm tab to work on dailygraphics with panes for dev server, dailygraphics fab/git and graphics git
alias graphics="osascript ~/Projects/dotfiles/applescript/iterm_dailygraphics.scpt"

# Reset bluetooth server
alias fixbluetooth="sudo killall blued"

# cd to dotfiles and open editor
alias config="cd ~/Code/dotfiles/ && code ."
