#!/bin/sh

if command -v nvim >/dev/null 2>&1; then
    echo "✅ Neovim already installed"
else
    echo "Installing neovim..."
    if command -v hostnamectl | grep Operating | cut -d ':' -f2 | tr -d ' '; then
        yay -Sy neovim
    else
        cd $HOME
        mkdir neovim && cd neovim
        wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage > /dev/null 2>&1

        chmod u+x nvim-linux-x86_64.appimage
        ./nvim-linux-x86_64.appimage --appimage-extract
        sudo ln -s $HOME/neovim/squashfs-root/usr/bin/nvim /usr/bin/nvim
    fi
fi

PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d $PACKER_DIR ]; then
    echo "Cloning neovim packer repo..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_DIR > /dev/null 2>&1
else
    echo "✅ Neovim packer repo already exists"
fi

NVIM_CFG_DIR=$HOME/.config/nvim
if [ ! -d $NVIM_CFG_DIR ]; then
    # verify stow existence, try installing or fallback to symbolic links
    echo "Creating nvim plugins configuration files symbolic links"
    cd $HOME && mkdir .config/
    ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim
else
    echo "✅ Neovim configs already installed"
fi

echo "Installing nvim plugins..."
nvim --headless -u $HOME/.config/nvim/lua/santos/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1


