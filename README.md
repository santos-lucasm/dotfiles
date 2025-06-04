### tmux

1. External dependencies

```
sudo add-apt-repository universe
```

```
sudo apt install ripgrep clangd libstdc++-12-dev libevent-dev bison flex libfuse2 stow automake autotools-dev libncurses-dev curl
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

4. Open tmux, type `prefix + I` to install the plugins using the `tmux-plugins/tpm` package


### neovim 

1. Install packer

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

2. Install nvim from the most recent deploy .appimage and put it in your $PATH.

```
chmod u+x nvim-linux-x86_64.appimage && ./nvim-linux-x86_64.appimage

// if your system does not have FUSE, extract the app image
./nvim-linux-x86_64.appimage --appimage-extract
./squashfs-root/usr/bin/nvim

// symbolic link it to your path
ln -s /home/<full_path_required>/squashfs-root/usr/bin/nvim /usr/bin/nvim
```

3. Install plugins

- To install a new plugin using packer, add it to ```nvim/lua/santos/packer.lua```.
- Source packer.lua and then run ```:PackerSync```
- To install more LSPs, check :Mason

New plugins configurations should be inside ```nvim/after/plugin/*.lua```.


### alacritty

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
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
```

```
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
```

```
sudo desktop-file-install extra/linux/Alacritty.desktop
```

```
sudo update-desktop-database
```

4. Update shortcut and turn alacritty into the default terminal emulator


```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
```

```
sudo update-alternatives --config x-terminal-emulator
```

## To add commands to run on boot

1. Edit `/etc/crontab` as sudo user
2. Add `@reboot sudo <command | script>`
3. To run an script, add it to `/usr/local/sbin/<created_script>`

