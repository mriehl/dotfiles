#!/usr/bin/env bash

## oracle java PPA
sudo add-apt-repository ppa:webupd8team/java

sudo add-apt-repository ppa:neovim-ppa/unstable

## fetch current packages
sudo apt-get update

## misc packages
sudo apt-get install oracle-java8-installer realpath acpi xbacklight xmonad xmobar dmenu python-dev curl arandr vim htop git python-pip subversion trayer xloadimage tree firefox libc6:i386 zlib1g:i386 nmap zsh vim i3 i3blocks feh terminology imagemagick scrot emacs tig neovim tmux
