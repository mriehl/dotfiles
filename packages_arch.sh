#!/usr/bin/env bash

sudo pacman -Sy
sudo pacman -S tmux yaourt vim python-pip python2-pip traceroute ruby ruby-ronn gcc make jdk7-openjdk acpi tree nmap git subversion

sudo pip install virtualenv

# avoid clashing keybindings with parcellite by removing it
sudo pacman -R parcellite
