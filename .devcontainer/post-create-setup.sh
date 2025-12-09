#!/bin/bash
# This file is executed once per session to set up the devcontainer.
# For example:
# echo "Running devcontainer setup script..."
# npm install

CURRENT_USER=$(whoami)
USER_HOME_DIR="$HOME"


echo "INFO: Creating Oh My Zsh custom directories..."
mkdir -p "$USER_HOME_DIR/.oh-my-zsh/custom/themes" "$USER_HOME_DIR/.oh-my-zsh/custom/plugins"

if [ -f "/workspaces/my-project/.devcontainer/.zshrc" ]; then
    echo "INFO: Copying .zshrc to $USER_HOME_DIR/.zshrc"
    cp "/workspaces/my-project/.devcontainer/.zshrc" "$USER_HOME_DIR/.zshrc"
    sudo chown "$CURRENT_USER:$CURRENT_USER" "$USER_HOME_DIR/.zshrc"
else
    echo "INFO: /workspaces/my-project/.devcontainer/.zshrc not found, skipping copy."
fi

if [ -f "/workspaces/my-project/.devcontainer/.p10k.zsh" ]; then
    echo "INFO: Copying .p10k.zsh to $USER_HOME_DIR/.p10k.zsh"
    cp "/workspaces/my-project/.devcontainer/.p10k.zsh" "$USER_HOME_DIR/.p10k.zsh"
    sudo chown "$CURRENT_USER:$CURRENT_USER" "$USER_HOME_DIR/.p10k.zsh"
else
    echo "INFO: /workspaces/my-project/.devcontainer/.p10k.zsh not found, skipping copy."
fi


echo "INFO: Configuring git safe directory..."
git config --global --add safe.directory /workspaces/my-project




echo "INFO: Adding Svelte MCP to Gemini..."
gemini mcp add -t http -s project svelte https://mcp.svelte.dev/mcp

echo "Setup bridget to access Chrome DevTools Protocol over a secure tunnel..."
socat TCP-LISTEN:9222,fork,bind=127.0.0.1 TCP:host.docker.internal:9222 &
