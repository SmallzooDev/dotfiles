#!/usr/bin/env bash

# script from https://github.com/johngrib/dotfiles

INDENT='.   '
INDENT2="$INDENT$INDENT"
INDENT3="$INDENT2$INDENT"
BACKUP_DIR="~/.backup-dotfiles"

mkdir -p "$BACKUP_DIR"


echo -e "\n각종 dotfile들의 symlink를 연결합니다."
create_symlink() {
    src=$1
    dest=$2

    if [ ! -e "$dest" ]; then
        ln -s "$src" "$dest"
        echo -e "\n$INDENT $dest 연결 완료."
        return 0
    fi

    echo -e "\n$INDENT $dest 가 이미 있습니다."
    read -p "$INDENT2 $dest 를 symlink로 replace 하시겠습니까? (y/n): " user_input
    if [ "$user_input" == "y" ]; then
        mv "$dest" "$BACKUP_DIR/"
        ln -s "$src" "$dest"
        echo "$INDENT3 $dest 가 연결되었습니다. 원본은 $BACKUP_DIR 에 백업되었습니다."
    else
        echo "$INDENT3 $dest 는 건너뜁니다."
    fi
}

create_symlink "$HOME/dotfiles/.zshrc" ~/.zshrc
create_symlink "$HOME/dotfiles/.zprofile" ~/.zprofile
create_symlink "$HOME/dotfiles/.ideavimrc" ~/.ideavimrc
create_symlink "$HOME/dotfiles/.tmux.conf" ~/.tmux.conf
create_symlink "$HOME/dotfiles/.wezterm.lua" ~/.wezterm.lua

mkdir -p ~/.config
create_symlink "$HOME/dotfiles/starship.toml" ~/.config/starship.toml
create_symlink "$HOME/dotfiles/nvim" ~/.config/nvim
create_symlink "$HOME/dotfiles/karabiner" ~/.config/karabiner
# create_symlink "$HOME/dotfiles/aerospace" ~/.config/aerospace
create_symlink "$HOME/dotfiles/bat" ~/.config/bat
create_symlink "$HOME/dotfiles/yazi" ~/.config/yazi
create_symlink "$HOME/dotfiles/helix" ~/.config/helix
