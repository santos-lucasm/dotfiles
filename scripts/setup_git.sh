#!/bin/bash

setup_git () {
    SSH_PATH="$HOME/.ssh"
    KEY_PATH="${SSH_PATH}/id_ed25519_github"

    if [ -f "$KEY_PATH" ]; then
        echo "Github personal key already exists. Exiting..."
        return 1;
    fi

    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -f "$KEY_PATH" -C "santos.lucasmmatheus@gmail.com"

    echo ""
    echo "Here is the SSH key created (https://github.com/settings/keys):"
    cat "${KEY_PATH}.pub"
    echo ""

    echo "Appending to ${SSH_PATH} configuration file..."
    cat <<EOF >> "$HOME/.ssh/config"
Host github-personal
    User git
    Hostname github.com
    IdentityFile ${KEY_PATH}
    IdentitiesOnly yes
EOF

    echo "Appending to git configuration file..."
    cat "./git/.gitconfig" >> "$HOME/.gitconfig"

    echo "Setup running ssh-agent"
    eval "$(ssh-agent -s)"
    ssh-add ${KEY_PATH}

    echo "Verifying github origin..."
    git remote set-url origin "git@github-personal:santos-lucasm/dotfiles.git"
    git remote -v
    ssh -T git@github-personal
}

setup_git
