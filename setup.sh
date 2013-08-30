#!/usr/bin/env bash
set -u -e -E -C -o pipefail

function install_required_libraries() {
    command -v realpath >>/dev/null 2>&1 || sudo apt-get install realpath
}

function install_source_code_pro() {
    find ~/.fonts -name "*SourceCodePro*" | grep -q '.' || {
        echo "SourceCodePro not installed, installing.."
        FONT_NAME="SourceCodePro"
        URL="http://sourceforge.net/projects/sourcecodepro.adobe/files/latest/download"

        mkdir /tmp/adodefont
        cd /tmp/adodefont
        wget ${URL} -O ${FONT_NAME}.zip
        unzip -o -j ${FONT_NAME}.zip
        mkdir -p ~/.fonts
        cp *.otf ~/.fonts
        fc-cache -f -v
    }
}


function install () {
    TARGET=$1
    FILE=`realpath "$2"`
    AS_ROOT=${3:-''}
    GAINROOT=""
    [[ "$AS_ROOT" == "as_root" ]] && GAINROOT="sudo "
    echo "Installing $FILE at $TARGET"
    [[ ! -d `dirname "$TARGET"` ]] && {
        echo "  creating upper directories.."
        $GAINROOT mkdir -p `dirname $TARGET`
    }
    [[ -d $TARGET || -L $TARGET || -f $TARGET ]] && {
        echo "  $TARGET exists, removing.."
        $GAINROOT rm -r "$TARGET"
    }

    $GAINROOT ln -s "$FILE" "$TARGET" && echo "  Installed $TARGET $AS_ROOT"

}

install_required_libraries

#---rcfiles
install ~/.vimrc rcfiles/.vimrc
install ~/.xmobarrc rcfiles/.xmobarrc
install ~/.xmonad rcfiles/.xmonad
install ~/.gitconfig rcfiles/.gitconfig

#---sublime text
#------snippets
install ~/.config/sublime-text-3/Packages/User/coroutine.sublime-snippet sublime/coroutine.sublime-snippet
install ~/.config/sublime-text-3/Packages/User/decorate_coroutine.sublime-snippet sublime/decorate_coroutine.sublime-snippet
#------settings
install ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings sublime/Preferences.sublime-settings
install ~/.config/sublime-text-3/Packages/User/Anaconda.sublime-settings sublime/Anaconda.sublime-settings
#------keybindings
install ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap sublime/Default\ \(Linux\).sublime-keymap
#------build systems
#---------python
install ~/.config/sublime-text-3/Packages/User/pyb-venv.sublime-build sublime/pyb-venv.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file.sublime-build sublime/python-single-file.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file-with-venv.sublime-build sublime/python-single-file-with-venv.sublime-build
#---------java
install ~/.config/sublime-text-3/Packages/User/mvn.sublime-build sublime/mvn.sublime-build
#---------js
install ~/.config/sublime-text-3/Packages/User/nodejs-single-file.sublime-build sublime/nodejs-single-file.sublime-build

#---scripts
install /usr/local/bin/statusbar statusbar as_root
install /usr/local/bin/xmonad-start xmonad-start as_root
install /usr/local/bin/xmobar-change-screen xmobar-change-screen as_root
install /usr/local/bin/pip-upgrade-all pip-upgrade-all as_root

#---fonts
install_source_code_pro
