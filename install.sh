#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

sudo apt update
sudo apt install -y stow zsh tmux bat git rsync curl wget libfuse2

# Ubuntu installs 'bat' as 'batcat' and 'eza' isn't always in old standard apt repos.
if [ -x /usr/bin/batcat ] && [ ! -e ~/.local/bin/bat ]; then
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# Install eza on Ubuntu if not present
if ! command -v eza &> /dev/null; then
    echo "==> Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza
fi

echo "==> Downloading and installing latest Neovim AppImage..."

mkdir -p ~/.local/bin

ARCH="$(uname -m)"
if [ "$ARCH" = "x86_64" ]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.appimage"
else
    echo "Error: Unsupported architecture: $ARCH"
    exit 1
fi

curl -L -o ~/.local/bin/nvim "$NVIM_URL"
chmod +x ~/.local/bin/nvim

# Ensure ~/.local/bin is in PATH for the rest of the script/session
export PATH="$HOME/.local/bin:$PATH"

echo "==> Setting up Zsh plugins and themes..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Oh-My-Zsh non-interactively if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Clone Powerlevel10k
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# Clone Zsh Autosuggestions
AUTOSUGGEST_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_DIR"
fi

# Clone Zsh Syntax Highlighting
HIGHLIGHT_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [ ! -d "$HIGHLIGHT_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HIGHLIGHT_DIR"
fi

echo "==> Stowing dotfiles..."
[ -f ~/.zshrc ] && rm -f ~/.zshrc

stow -v -R zsh tmux nvim

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "==> Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi
