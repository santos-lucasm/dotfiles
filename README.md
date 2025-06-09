## Install tmux

1. External dependencies

```
sudo add-apt-repository universe
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


## Install neovim 

1. Run the repo neovim installation script that clones neovim packer plugin, downloads and
extracts neovim v0.11.2 and install the plugins.

2. Observations

New plugins configurations should be inside ```nvim/after/plugin/*.lua```.
- To install a new plugin using packer, add it to ```nvim/lua/santos/packer.lua```.
- Source packer.lua and then run ```:PackerSync```
- To install more LSPs, check :Mason


## Install alacritty

1. Install dependencies

```
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
```

2. Build alacritty from source

```
git clone https://github.com/alacritty/alacritty.git
cargo build --release
infocmp alacritty && sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
```

3. Install and create a valid desktop entry

```
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
```

4. Update shortcut and turn alacritty into the default terminal emulator


```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
sudo update-alternatives --config x-terminal-emulator
```

## To add commands to run on boot

1. Edit `/etc/crontab` as sudo user
2. Add `@reboot sudo <command | script>`
3. To run an script, add it to `/usr/local/sbin/<created_script>`

## Useful aliases

```
alias devcode='devcontainer exec --workspace-folder . nvim /workspaces/systemx_io'
alias deventer='devcontainer exec --workspace-folder . /bin/bash'
alias devup='devcontainer up --workspace-folder . --remove-existing-container\
    --dotfiles-repository "https://github.com/santos-lucasm/dotfiles.git"\
    --dotfiles-install-command ".config/nvim/scripts/install_nvim_container.sh"'
```

## Error handling

1. `<leader>ps` not working inside neovim

Check error with `:message`, you probably forgot to install `ripgrep` apt lib.

2. File system read-only mode in WSL

```
mount -v | grep ro // verify the partition name
sudo e2fsck <partition_name> -y // /dev/sdb
sudo e2fsck <partition_name> -p
wsl --shutdown // in windows cmd
```
