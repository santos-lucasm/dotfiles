GIT_CFG="${HOME}/ws/personal-cfg"
LOCAL_CFG="${HOME}/.config"

symlink_file () {
    ln -s "${GIT_CFG}/$1" "${LOCAL_CFG}/$1"
}

rm -rf ~/.config/nvim

mkdir ~/.config/nvim
symlink_file "nvim/init.lua"

# Lua profile
mkdir -p ~/.config/nvim/lua/santos
symlink_file "nvim/lua/santos/init.lua"
symlink_file "nvim/lua/santos/packer.lua"
symlink_file "nvim/lua/santos/remap.lua"
symlink_file "nvim/lua/santos/set.lua"

# Nvim plugins cfg
mkdir -p ~/.config/nvim/after/plugin
symlink_file "nvim/after/plugin/telescope.lua"
symlink_file "nvim/after/plugin/treesitter.lua"

mkdir -p ~/.config/nvim/plugin
symlink_file "nvim/plugin/colors.lua"
symlink_file "nvim/plugin/plugins.lua"