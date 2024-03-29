#!/bin/bash

GIT_CFG="${HOME}/ws/personal-cfg"

symlink_file () {
    ln -s $1 $2
}

install_files_from() {
    for filename in ${GIT_CFG}/$1/*.lua; do
        symlink_file "${filename}" "${HOME}/.config/$1/$(basename "$filename")"
    done
}

rm -rf ~/.config/nvim

mkdir ~/.config/nvim
install_files_from "nvim"

# Lua profile
mkdir -p ~/.config/nvim/lua/santos
install_files_from "nvim/lua/santos"

# Nvim plugins cfg
mkdir -p ~/.config/nvim/after/plugin
install_files_from "nvim/after/plugin"
