#!/bin/sh

set -e # -e: exit on error

cd /home/ubuntu/Code
git clone git@github.com:planningcenter/tapestry-react.git
git clone git@github.com:planningcenter/doxy-web.git

curl -Ssf https://pkgx.sh | sh

echo "Installing zsh"
sudo apt install -y zsh
sudo chsh $(whoami) -s /usr/bin/zsh

