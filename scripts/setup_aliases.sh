#!/bin/bash

setup_aliases () {
    echo "alias devcode='devcontainer exec --workspace-folder . nvim /workspaces/${PWD##*/}'" >> ~/.bashrc
    echo "alias deventer='devcontainer exec --workspace-folder . /bin/bash'" >> ~/.bashrc
    echo "alias devup='devcontainer up --workspace-folder . --remove-existing-container \
        --dotfiles-repository \"https://github.com/santos-lucasm/dotfiles.git\" \
        --dotfiles-install-command \"./neovim/.config/nvim/scripts/install_nvim_container.sh\"'" >> ~/.bashrc
    echo "setxkbmap -option caps:escape" >> ~/.bashrc

    echo "Don't forget to: source ~/.bashrc!!"
}

setup_aliases
