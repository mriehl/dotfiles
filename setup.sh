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
echo "---zsh"
install ~/.zshrc rcfiles/.zshrc
install ~/.zshrc.local rcfiles/.zshrc.local
echo "---i3"
install ~/.i3 rcfiles/i3
echo "---git"
install ~/.gitconfig rcfiles/.gitconfig
echo "---tmux"
install ~/.tmux.conf rcfiles/.tmux.conf
install ~/.tmux/plugins/tpm deps/tpm
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
cp resources/ssh-agent.service ~/.config/systemd/user/ssh-agent.service

install ~/.rustfmt.toml rcfiles/.rustfmt.toml

install ~/.config/dunst/dunstrc rcfiles/dunstrc

install ~/.config/starship.toml rcfiles/starship.toml
install ~/.config/alacritty.yml rcfiles/alacritty.yml

install ~/.xsession rcfiles/xsession
install ~/.xsessionrc rcfiles/xsessionrc

#---scripts
echo "--installing scripts"
install /usr/local/bin/pwn-docker bin/pwn-docker as_root
install /usr/local/bin/byepass bin/byepass as_root
install /usr/local/bin/i3lock.sh bin/i3lock.sh as_root

install /usr/local/bin/key_layout bin/key_layout as_root
install /usr/local/bin/brightness-i3 bin/brightness-i3 as_root
