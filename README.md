# Setup

Use the `scripts/set_me_up.sh` to configure a new environment. Check the usage to verify what the script can install.

Tested for:

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS

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

## Error handling

1. New nvim plugins

New plugins configurations should be inside ```nvim/after/plugin/*.lua```.
- To install a new plugin using packer, add it to ```nvim/lua/santos/packer.lua```.
- Source packer.lua and then run ```:PackerSync```
- To install more LSPs, check :Mason

2. File system read-only mode in WSL

```
mount -v | grep ro // verify the partition name
sudo e2fsck <partition_name> -y // /dev/sdb
sudo e2fsck <partition_name> -p
wsl --shutdown // in windows cmd
```
3. Handle work and personal github keys

Add the following to your `~/.ssh/config`

```
Host github-personal
    User git
    Hostname github.com
    IdentityFile ~/.ssh/id_ed25519_github
    IdentitiesOnly yes
```

And then close this repository with `git clone git@github-personal:santos-lucasm/dotfiles.git`

To test it, you can run `ssh -T git@github-personal`

4. After creating or update your ssh key

The following command resets the ssh-agent: `eval "$(ssh-agent -s)"`

To add the new key: `ssh-add ~/.ssh/id-path-private-key`
