#!/usr/bin/env bash
set -u -e -E -C -o pipefail

function install_required_libraries() {
    echo "-checking availability of required libraries"
    command -v realpath >>/dev/null 2>&1 || sudo apt-get install realpath
}

function install () {
    TARGET=$1
    FILE=`realpath "$2"`
    AS_ROOT=${3:-''}
    GAINROOT=""
    [[ "$AS_ROOT" == "as_root" ]] && GAINROOT="sudo "
    [[ ! -d `dirname "$TARGET"` ]] && {
        $GAINROOT mkdir -p `dirname $TARGET`
    }
    [[ -d $TARGET || -L $TARGET || -f $TARGET ]] && {
        $GAINROOT rm -r "$TARGET"
    }

    $GAINROOT ln -s "$FILE" "$TARGET"

}

install_required_libraries

echo "-installing dotfiles"

#---rcfiles
echo "--installing rcfiles"
echo "---zsh"
install ~/.zshrc rcfiles/.zshrc
install ~/.zshrc.local rcfiles/.zshrc.local
echo "---vim"
install ~/.vimrc rcfiles/.vimrc
echo "---xmonad"
install ~/.xmobarrc rcfiles/.xmobarrc
install ~/.xmonad rcfiles/.xmonad
echo "---git"
install ~/.gitconfig rcfiles/.gitconfig
echo "---tmux"
install ~/.tmux.conf rcfiles/.tmux.conf
echo "---conky"
install ~/.conkyrc rcfiles/.conkyrc
echo "---python"
install ~/.pythonrc.py rcfiles/.pythonrc.py

#---sublime text
echo "--installing ST3 config"
#------snippets
echo "---snippets"
install ~/.config/sublime-text-3/Packages/User/coroutine.sublime-snippet sublime/coroutine.sublime-snippet
install ~/.config/sublime-text-3/Packages/User/decorate_coroutine.sublime-snippet sublime/decorate_coroutine.sublime-snippet
echo "---settings"
install ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings sublime/Preferences.sublime-settings
install ~/.config/sublime-text-3/Packages/User/Anaconda.sublime-settings sublime/Anaconda.sublime-settings
install ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings sublime/Package\ Control.sublime-settings
install ~/.config/sublime-text-3/Packages/User/GoSublime-Go.sublime-settings sublime/GoSublime-Go.sublime-settings
install ~/.config/sublime-text-3/Packages/User/GoSublime.sublime-settings sublime/GoSublime.sublime-settings
echo "---keybindings"
install ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap sublime/Default\ \(Linux\).sublime-keymap
echo "---build systems"
echo "----python"
install ~/.config/sublime-text-3/Packages/User/pyb-venv.sublime-build sublime/pyb-venv.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file.sublime-build sublime/python-single-file.sublime-build
install ~/.config/sublime-text-3/Packages/User/python-single-file-with-venv.sublime-build sublime/python-single-file-with-venv.sublime-build
echo "----java"
install ~/.config/sublime-text-3/Packages/User/mvn.sublime-build sublime/mvn.sublime-build
echo "----js"
install ~/.config/sublime-text-3/Packages/User/nodejs-single-file.sublime-build sublime/nodejs-single-file.sublime-build

#---scripts
echo "--installing scripts"
install /usr/local/bin/statusbar bin/statusbar as_root
install /usr/local/bin/xmonad-start bin/xmonad-start as_root
install /usr/local/bin/xmobar-change-screen bin/xmobar-change-screen as_root
install /usr/local/bin/pip-upgrade-all bin/pip-upgrade-all as_root
install /usr/local/bin/go-upgrade bin/go-upgrade as_root
install /usr/local/bin/pycharm bin/pycharm as_root
install /usr/local/bin/pwn-docker bin/pwn-docker as_root
install /usr/local/bin/render-wireless bin/render_wireless as_root
install /usr/local/bin/passme bin/passme as_root
