#!/bin/bash

command -v realpath >>/dev/null 2>&1 || sudo apt-get install realpath

function install () {
    TARGET=$1
    FILE=`realpath $2`
    AS_ROOT=$3
    echo "Installing $FILE at $TARGET"
    [[ ! -d `dirname $TARGET` ]] && {
        echo "  creating upper directories.."
        [[ "$AS_ROOT" == "as_root" ]] && sudo mkdir -p `dirname $TARGET`
        [[ "$AS_ROOT" == "as_root" ]] || mkdir -p `dirname $TARGET`
    }
    [[ -f $TARGET ]] && {
        echo "  $TARGET exists, removing.."
        [[ "$AS_ROOT" == "as_root" ]] && sudo rm -f $TARGET
        [[ "$AS_ROOT" == "as_root" ]] || rm -f $TARGET
    }
    [[ -d $TARGET ]] && {
        echo "  $TARGET exists (dir), removing.."
        [[ "$AS_ROOT" == "as_root" ]] && sudo rm -rf $TARGET
        [[ "$AS_ROOT" == "as_root" ]] || rm -rf $TARGET
    }

    [[ "$AS_ROOT" == "as_root" ]] && sudo ln -s $FILE $TARGET && echo "  Installed $TARGET as root"
    [[ "$AS_ROOT" == "as_root" ]] || ln -s $FILE $TARGET && echo "  Installed $TARGET"
    
}

install ~/.vimrc .vimrc
install ~/.xmobarrc .xmobarrc
install ~/.xmonad .xmonad

install ~/.config/sublime-text-3/Packages/User/coroutine.sublime-snippet sublime/coroutine.sublime-snippet
install ~/.config/sublime-text-3/Packages/User/decorate_coroutine.sublime-snippet sublime/decorate_coroutine.sublime-snippet
install ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings sublime/Preferences.sublime-settings
install ~/.config/sublime-text-3/Packages/User/pyb-venv.sublime-build sublime/pyb-venv.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file.sublime-build sublime/python-single-file.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file-with-venv.sublime-build sublime/python-single-file-with-venv.sublime-build

install /usr/local/bin/statusbar statusbar as_root
install /usr/local/bin/xmonad-start xmonad-start as_root
