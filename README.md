## External dependencies


```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Install nvim from the most recent deploy .appimage and put it in your $PATH.

### Install tmux

1. External dependencies

```
sudo add-apt-repository universe
```

```
sudo apt install ripgrep clangd libstdc++-12-dev libevent-dev bison flex libfuse2 stow automake autotools-dev libncurses-dev
```

2. Build from source

```
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo cp tmux /usr/local/bin/
```

3. Download tmux plugins repository

```
 git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Install alacritty

1. Install dependencies

```
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
```

2. Build alacritty from source

```
git clone https://github.com/alacritty/alacritty.git
```

```
cargo build --release
```

```
infocmp alacritty && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
```

3. Install and create a valid desktop entry

```
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH`
```

```
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg`
```

```
sudo desktop-file-install extra/linux/Alacritty.desktop`
```

```
sudo update-desktop-database`
```

4. Update shortcut and turn alacritty into the default terminal emulator


```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
```

```
sudo update-alternatives --config x-terminal-emulator
```


## Comments

1. Add plugins configurations inside ```nvim/after/plugin/*.lua```.
2. To install a new plugin using packer, add it to ```nvim/lua/santos/packer.lua```.
3. Do not forget to run the install script, source packer.lua and then run ```:PackerSync```
4. To install lsp, check :Mason

