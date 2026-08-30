#!/bin/bash

install_deps () {
    echo "Installing dependencies..."
	export DEBIAN_FRONTEND=noninteractive

	sudo add-apt-repository universe -y > /dev/null 2>&1

	sudo apt install -y \
	    apt-transport-https \
        automake \
        autotools-dev \
        bison \
	    build-essential \
	    ca-certificates \
        cargo \
        clangd \
        cmake \
        curl \
        flex \
        libstdc++-12-dev \
        libevent-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfuse2 \
        libncurses-dev \
        libxcb-xfixes0-dev \
        libxkbcommon-dev
	    npm \
        pkg-config \
        python3 \
        python3-venv \
        ripgrep \
	    software-properties-common \
        stow \
	    unzip \
	    > /dev/null 2>&1

    sudo npm install -g @devcontainers/cli
}

install_nvim () {
	if command -v nvim >/dev/null 2>&1; then
	    echo "✅ Neovim already installed."
	else
	    echo "Installing neovim..."
	    mkdir -p ~/third_party/neovim && pushd ~/third_party/neovim
	    wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage > /dev/null 2>&1
	    chmod u+x nvim-linux-x86_64.appimage
	    ./nvim-linux-x86_64.appimage --appimage-extract
	    sudo mv squashfs-root /opt/neovim
	    sudo ln -sf /opt/neovim/usr/bin/nvim /usr/bin/nvim
	fi

	PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
	if [ ! -d $PACKER_DIR ]; then
	    echo "Cloning neovim packer repo..."
	    git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_DIR > /dev/null 2>&1
	else
	    echo "✅ Neovim packer repo already exists"
	fi

	echo "Installing nvim plugins..."
	nvim --headless -u $HOME/.config/nvim/lua/santos/packer.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 2>&1
    popd
}

install_tmux () {
    if command -v tmux >/dev/null 2>&1; then
        echo "✅ Tmux already installed."
    else
        echo "Installing tmux..."
        mkdir -p ~/third_party/
        cd ~/third_party/
        git clone https://github.com/tmux/tmux.git > /dev/null 2>&1
        cd tmux
        sh autogen.sh > /dev/null 2>&1
        ./configure && make > /dev/null 2>&1
        sudo cp tmux /usr/local/bin/
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
        ~/.tmux/plugins/tpm/bin/install_plugins
    fi
}

install_docker () {
    if command -v docker >/dev/null 2>&1; then
        echo "✅ Docker already installed."
    else
        echo "Installing docker..."
        export DEBIAN_FRONTEND=noninteractive
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update -y > /dev/null 2>&1
        sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y > /dev/null 2>&1
        sudo usermod -aG docker $USER
        echo "Add the following line to ~/.docker/config.json file."
        echo "\"detachKeys\": \"ctrl-e,e\""
        echo "Restart required to use docker without sudo."
    fi
}

install_fonts () {
    echo "Installing nerd fonts..."
    FONTS_DIR=~/dotfiles/fonts
    if [ -d "$FONTS_DIR" ]; then
        echo "Not found fonts folder in ${FONTS_DIR}. Make sure dotfiles are cloned in ${HOME} folder."
       exit 1 
    fi
    mkdir -p ~/.local/share/fonts
    unzip ${FONTS_DIR}/FiraCode.zip -d ${FONTS_DIR} > /dev/null 2>&1
    cp ${FONTS_DIR}/*.ttf ~/.local/share/fonts/ > /dev/null 2>&1
    fc-cache -f -v
}

for arg; do
	if [[ "$arg" == "--all" ]]; then
		install_deps
        stow --target=$HOME neovim
        install_nvim && install_tmux && install_docker && install_fonts
	elif [[ "$arg" == "--install-dep" ]]; then
		install_deps
	elif [[ "$arg" == "--nvim" ]]; then
		install_nvim
    elif [[ "$arg" == "--tmux" ]]; then
        install_tmux
    elif [[ "$arg" == "--docker" ]]; then
        install_docker
    elif [[ "$arg" == "--fonts" ]]; then
        install_fonts
	else
		echo "Option $arg not recognized."
        exit 1
	fi
done

