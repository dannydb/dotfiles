#!/bin/sh

set -e # -e: exit on error

cd /home/ubuntu/Code
echo "Cloning design system repos"
git clone git@github.com:planningcenter/tapestry-react.git
git clone git@github.com:planningcenter/doxy-web.git

echo "Installing pkgx"
curl -Ssf https://pkgx.sh | sh

echo "Installing zsh"
sudo apt install -y zsh
sudo chsh $(whoami) -s /usr/bin/zsh

