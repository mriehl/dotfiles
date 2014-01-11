#!/usr/bin/env bash

sudo pacman -Sy
sudo pacman -S tmux yaourt vim python-pip python2-pip traceroute ruby gcc make jdk7-openjdk acpi tree nmap git subversion xmonad-contrib xmobar

sudo yaourt -Sy

sudo pip install --upgrade virtualenv

# avoid clashing keybindings with parcellite by removing it
sudo pacman -R parcellite
