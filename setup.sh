#!/usr/bin/env bash
set -u -e -E -C -o pipefail

function install_required_libraries() {
    echo "-checking availability of required libraries"
    command -v realpath >>/dev/null 2>&1 || sudo apt-get install realpath
}

function install_source_code_pro() {
    echo "-checking SourceCodePro installation"
    find ~/.fonts -name "*SourceCodePro*" | grep -q '.' || {
        echo "--SourceCodePro not installed, installing"
        FONT_NAME="SourceCodePro"
        URL="http://sourceforge.net/projects/sourcecodepro.adobe/files/latest/download"

        mkdir /tmp/adodefont
        cd /tmp/adodefont
        wget ${URL} -O ${FONT_NAME}.zip
        unzip -o -j ${FONT_NAME}.zip
        mkdir -p ~/.fonts
        cp *.otf.woff ~/.fonts
        fc-cache -f -v
    }
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

echo "-pulling in dependencies"
git submodule init
git submodule update

install_required_libraries

echo "-installing dotfiles"

#---rcfiles
echo "--installing rcfiles"
echo "---zsh"
install ~/.zshrc rcfiles/.zshrc
install ~/.zshrc.local rcfiles/.zshrc.local
echo "---fish"
install ~/.config/fish/config.fish rcfiles/fish/config.fish
echo "---vim"
install ~/.vimrc rcfiles/.vimrc
install ~/.vim/autoload/pathogen.vim rcfiles/.vim/autoload/pathogen.vim
echo "----pathogen plugins"
install ~/.vim/bundle/jedi-vim rcfiles/.vim/bundle/jedi-vim/
install ~/.vim/bundle/nerdtree rcfiles/.vim/bundle/nerdtree/
install ~/.vim/bundle/ctrlp.vim rcfiles/.vim/bundle/ctrlp.vim/
install ~/.vim/bundle/rust.vim rcfiles/.vim/bundle/rust.vim/
install ~/.vim/bundle/racer/autoload/racer.vim rcfiles/.vim/bundle/racer/editors/racer.vim
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
install ~/.config/ipython/profile_default/ipython_config.py rcfiles/ipythonrc.py
echo "---gpg"
install ~/.gnupg/gpg-agent.conf rcfiles/gpg-agent.conf
install ~/.gnupg/gpg.conf rcfiles/gpg.conf

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
install /usr/local/bin/pwn-docker bin/pwn-docker as_root
install /usr/local/bin/render-wireless bin/render_wireless as_root
install /usr/local/bin/passme bin/passme as_root
install /usr/local/bin/byepass bin/byepass as_root
install /usr/local/bin/rustup bin/rustup.sh as_root
install /usr/local/bin/drm bin/drm as_root

#---fonts
install_source_code_pro
