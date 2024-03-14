#!/bin/sh

set -eu

sudo apt update

# Install zsh if it's not already installed
if ! command -v zsh >/dev/null; then
  sudo apt install zsh
  chsh -s $(which zsh)
fi

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install nvim if it's not already installed
if ! command -v nvim >/dev/null; then
  sudo apt install neovim
fi