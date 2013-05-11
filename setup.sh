#!/bin/bash

command -v realpath >>/dev/null 2>&1 || sudo apt-get install realpath

function install () {
    TARGET=$1
    FILE=`realpath $2`
    echo "Installing $FILE at $TARGET"
    [[ -f $TARGET ]] && {
        echo "  $TARGET exists, removing.."
        rm -f $TARGET
    }
    [[ -d $TARGET ]] && {
        echo "  $TARGET exists (dir), removing.."
        rm -rf $TARGET
    }

    ln -s $FILE $TARGET && echo "  Installed $TARGET"
}

install ~/.vimrc .vimrc
install ~/.xmobarrc .xmobarrc
install ~/.xmonad .xmonad
