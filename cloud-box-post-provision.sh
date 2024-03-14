#!/bin/sh

set -e # -e: exit on error

cd /home/Ubuntu/Code
git clone git@github.com:planningcenter/tapestry-react.git
git clone git@github.com:planningcenter/doxy-web.git

if [ ! "$(command -v pkgx)" ]; then
	curl -Ssf https://pkgx.sh | sh
else
    echo "pkgx already installed."
fi

pkgx chezmoi init dannydb --apply

