## External dependencies

```
sudo add-apt-repository universe

sudo apt install ripgrep clangd libstdc++-12-dev libevent-devel bison libfuse2

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

 git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install nvim from the most recent deploy .appimage and put it in your $PATH.

Install tmux from source code.

## Comments

1. Add plugins configurations inside ```nvim/after/plugin/*.lua```.
2. To install a new plugin using packer, add it to ```nvim/lua/santos/packer.lua```.
3. Do not forget to run the install script, source packer.lua and then run ```:PackerSync```
4. To install lsp, check :Mason

