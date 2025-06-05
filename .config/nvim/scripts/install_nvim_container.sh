#!/bin/sh

if command -v nvim >/dev/null 2>&1; then
    echo "Nvim already installed. Exiting..."
    exit
fi

echo "Downloading nvim..."
cd $HOME
mkdir neovim && cd neovim
wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage > /dev/null 2>&1

echo "Installing nvim..."
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
sudo ln -s $HOME/neovim/squashfs-root/usr/bin/nvim /usr/bin/nvim

echo "Cloning nvim packer repo..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim > /dev/null 2>&1

echo "Creating nvim plugins configuration files symbolic links"
cd $HOME && mkdir .config/
ln -s $HOME/dotfiles/.config/nvim $HOME/.config/nvim

echo "Installing nvim plugins..."
nvim --headless -u $HOME/.config/nvim/lua/santos/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1


