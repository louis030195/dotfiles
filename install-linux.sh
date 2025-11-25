#!/usr/bin/env bash
# Linux-specific setup

echo "=== Linux Setup ==="

if command -v apt &> /dev/null; then
    sudo apt update && sudo apt install -y git curl build-essential
elif command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm git curl base-devel
fi

# Install Rust
if ! command -v rustup &> /dev/null; then
    curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# Setup Zed config
ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/zed/settings.json" "$ZED_CONFIG_DIR/"

# Setup Claude Code
mkdir -p ~/.claude
cp "$DOTFILES_DIR/claude/CLAUDE.md" ~/.claude/
cp "$DOTFILES_DIR/claude/settings.json" ~/.claude/

echo "Linux setup complete!"
