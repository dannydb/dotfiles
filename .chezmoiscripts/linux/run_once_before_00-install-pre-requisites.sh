#!/bin/sh

set -eu

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else 
	echo "Homebrew already installed."
fi

brew update

brew bundle --no-lock --file=/dev/stdin <<EOF
{{ range .packages.linux.brews -}}
brew {{ . | quote }}
{{ end -}}
EOF
