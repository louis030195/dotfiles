#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

echo "Dotfiles directory: $DOTFILES_DIR"

case "$(uname -s)" in
    Darwin)
        echo "Detected macOS"
        source "$DOTFILES_DIR/install-mac.sh"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        echo "Detected Windows (Git Bash/MSYS2)"
        source "$DOTFILES_DIR/install-windows.sh"
        ;;
    Linux)
        echo "Detected Linux"
        source "$DOTFILES_DIR/install-linux.sh"
        ;;
    *)
        echo "Unknown OS: $(uname -s)"
        exit 1
        ;;
esac

echo "Setting up shell configs..."
cp "$DOTFILES_DIR/shell/.bashrc" ~/
cp "$DOTFILES_DIR/shell/.bash_profile" ~/
cp "$DOTFILES_DIR/shell/.aliases" ~/
cp "$DOTFILES_DIR/shell/.exports" ~/

echo "Setting up git..."
cp "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore
git config --global core.excludesfile ~/.gitignore
git config --global user.name "louis030195"
git config --global user.email "louis.beaumont@gmail.com"
git config --global core.longpaths true

echo "Setting up wezterm..."
mkdir -p ~/.config/wezterm
cp "$DOTFILES_DIR/wezterm/wezterm.lua" ~/.config/wezterm/

echo "Cloning repos..."
source "$DOTFILES_DIR/clone-repos.sh"

echo "Done! Restart your terminal."
