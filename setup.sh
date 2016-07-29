#!/usr/bin/env bash
set -u -e -E -C -o pipefail

function fatal() {
    echo "$1"
    exit 1
}

function check_required_libraries() {
    echo "-checking availability of required libraries"
    command -v grealpath >>/dev/null && REALPATH="grealpath"
    command -v realpath >>/dev/null && REALPATH="realpath"
    [ -z ${REALPATH+x} ] && REALPATH="readlink -f" || :
}

function install_source_code_pro() {
    echo "-checking SourceCodePro installation"
    find ~/.fonts -name "*SourceCodePro*" | grep -q '.' || {
        echo "--SourceCodePro not installed, installing"
        FONT_NAME="SourceCodePro"
        URL="https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip"

        mkdir  /tmp/adobefont
        cd /tmp/adobefont
        wget ${URL} -O ${FONT_NAME}.zip
        unzip -o -j ${FONT_NAME}.zip
        mkdir -p ~/.fonts
        cp *.otf.woff ~/.fonts
        fc-cache -f -v
    }
}

function install () {
    TARGET=$1
    FILE=$($REALPATH "$2")
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

echo "-pulling in dependencies"
git submodule update --remote --init --recursive || {
    git submodule update --init --recursive
}

check_required_libraries

echo "-installing dotfiles"

#---rcfiles
echo "--installing rcfiles"
echo "---mjolnir"
install ~/.mjolnir rcfiles/mjolnir
echo "---zsh"
install ~/.zshrc rcfiles/.zshrc
install ~/.zshrc.local rcfiles/.zshrc.local
echo "---fish"
install ~/.config/fish/config.fish rcfiles/fish/config.fish
echo "---vim"
install ~/.config/nvim/init.vim rcfiles/.vimrc
install ~/.config/nvim/autoload/plug.vim rcfiles/.vim/autoload/plug.vim
echo "----pathogen plugins"
install ~/.config/nvim/bundle rcfiles/.vim/bundle
echo "---xmonad"
install ~/.xmobarrc rcfiles/.xmobarrc
install ~/.xmonad rcfiles/.xmonad
echo "---i3"
install ~/.i3 rcfiles/i3
echo "---git"
install ~/.gitconfig rcfiles/.gitconfig
echo "---tmux"
install ~/.tmux.conf rcfiles/.tmux.conf
install ~/.tmux/plugins/tpm deps/tpm
echo "---conky"
install ~/.conkyrc rcfiles/.conkyrc
echo "---python"
install ~/.pythonrc.py rcfiles/.pythonrc.py
install ~/.config/ipython/profile_default/ipython_config.py rcfiles/ipythonrc.py
echo "---gpg"
install ~/.gnupg/gpg-agent.conf rcfiles/gpg-agent.conf
install ~/.gnupg/gpg.conf rcfiles/gpg.conf
echo "---emacs"
install ~/.emacs.d rcfiles/emacs.d
mkdir -p ~/.config/systemd/user
cp resources/emacs.service ~/.config/systemd/user/emacs.service

echo "--installing light table config"
install ~/.config/LightTable/User/user.behaviors light-table/user.behaviors
install ~/.config/LightTable/User/user.keymap light-table/user.keymap

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
install ~/.config/sublime-text-3/Packages/User/RustAutoComplete.sublime-settings sublime/RustAutoComplete.sublime-settings
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
install /usr/local/bin/light-table bin/light-table as_root
install /usr/local/bin/pwn-docker bin/pwn-docker as_root
install /usr/local/bin/render-wireless bin/render_wireless as_root
install /usr/local/bin/passme bin/passme as_root
install /usr/local/bin/byepass bin/byepass as_root
install /usr/local/bin/rustup bin/rustup.sh as_root
install /usr/local/bin/drm bin/drm as_root
install /usr/local/bin/i3lock.sh bin/i3lock.sh as_root
install /usr/local/bin/lein bin/lein as_root
install /usr/local/bin/pyb-vim bin/pyb-vim as_root
install /usr/local/bin/toggle-touchpad bin/toggle-touchpad.sh as_root

install /usr/local/bin/radar-base.sh deps/git-radar/radar-base.sh as_root
install /usr/local/bin/prompt.zsh deps/git-radar/prompt.zsh as_root
install /usr/local/bin/git-radar deps/git-radar/git-radar as_root
install /usr/local/bin/key_layout bin/key_layout as_root
install /usr/local/bin/brightness-i3 bin/brightness-i3 as_root

#---fonts
if [[ $(uname) == 'Linux' ]]; then
    install_source_code_pro
else
    echo "Please install source code pro yourself"
fi
