#!/bin/bash -e

if [ ! -d ~/.dotfiles ]; then
  git clone git://github.com/neersighted/dotfiles.git ~/.dotfiles
fi

ln -sf ~/.dotfiles/freshrc ~/.freshrc
bash -c "$(curl -sL get.freshshell.com)"
