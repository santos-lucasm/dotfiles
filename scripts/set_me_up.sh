#!/bin/sh

# Install dependencies
echo "Installing dependencies..."
sudo add-apt-repository universe -y > /dev/null 2>&1

sudo apt install \
    ripgrep \
    clangd \
	libstdc++-12-dev \
    libevent-dev \
	bison \
    flex \
	libfuse2 \
    stow \
	automake \
    autotools-dev \
	libncurses-dev curl \
    unzip python3-venv \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    npm \
	pkg-config \
    build-essential \
    -y > /dev/null 2>&1

# Create configuration symbolic links
echo "Using stow to link configuration files..."
stow .

# Install tmux
if command -v tmux >/dev/null 2>&1; then
	echo "✅ Tmux already installed."
else
	echo "Installing neovim..."
	mkdir -p ~/third_party/
	cd ~/third_party/
	git clone https://github.com/tmux/tmux.git
	cd tmux
	sh autogen.sh
	./configure && make
	sudo cp tmux /usr/local/bin/
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins
fi

# Install neovim
if command -v nvim >/dev/null 2>&1; then
    echo "✅ Neovim already installed."
else
    echo "Installing neovim..."
    cd $HOME
    mkdir -p ~/third_party/neovim && cd ~/third_party/neovim
    wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage > /dev/null 2>&1
    chmod u+x nvim-linux-x86_64.appimage
    ./nvim-linux-x86_64.appimage --appimage-extract
    sudo ln -s $HOME/third-party/neovim/squashfs-root/usr/bin/nvim /usr/bin/nvim
fi

PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d $PACKER_DIR ]; then
    echo "Cloning neovim packer repo..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_DIR > /dev/null 2>&1
else
    echo "Neovim packer repo already exists"
fi

echo "Installing nvim plugins..."
nvim --headless -u $HOME/.config/nvim/lua/santos/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1

if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker already installed."
else
    echo "Installing docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    sudo usermod -aG docker $USER
fi
