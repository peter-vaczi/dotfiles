#!/bin/bash -e

if [ ! -d ~/.dotfiles ]; then
  git clone git://github.com/peter-vaczi/config_stuff.git ~/.dotfiles
fi

ln -sf ~/.dotfiles/freshrc ~/.freshrc
bash -c "$(curl -sL get.freshshell.com)"
