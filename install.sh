#!/bin/sh

set -e # -e: exit on error

if [ ! "$(command -v pkgx)" ]; then
	curl -Ssf https://pkgx.sh | sh
else
    echo "pkgx already installed."
fi

pkgx chezmoi init dannydb --apply

