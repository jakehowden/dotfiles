#!/usr/bin/env bash
# Symlinks everything in linux/.config into ~/.config.
# Anything already there (and not a symlink) is moved to <name>.bak.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.config

for src in "$here"/.config/*; do
  dest=~/.config/"$(basename "$src")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bak"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest"
done
