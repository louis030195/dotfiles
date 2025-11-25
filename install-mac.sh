#!/usr/bin/env bash
# macOS setup

echo "=== macOS Setup ==="

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing apps via Homebrew..."

# CLI tools
brew install git node rustup-init bash python gh helix

# Apps
brew install --cask wezterm zed cursor claude obsidian discord slack google-chrome tailscale

# Initialize rust
rustup-init -y 2>/dev/null || true
rustup default stable

# Install claude code
npm install -g @anthropic-ai/claude-code 2>/dev/null || true

# Setup Zed config
echo "Setting up Zed..."
ZED_CONFIG_DIR="$HOME/.config/zed"
mkdir -p "$ZED_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/zed/settings.json" "$ZED_CONFIG_DIR/"

# Setup Cursor config
echo "Setting up Cursor..."
CURSOR_CONFIG_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/cursor/settings.json" "$CURSOR_CONFIG_DIR/"
cp "$DOTFILES_DIR/editors/cursor/keybindings.json" "$CURSOR_CONFIG_DIR/"

# Setup Helix config
echo "Setting up Helix..."
HELIX_CONFIG_DIR="$HOME/.config/helix"
mkdir -p "$HELIX_CONFIG_DIR"
cp "$DOTFILES_DIR/helix/config.toml" "$HELIX_CONFIG_DIR/"

# Setup Claude Code
echo "Setting up Claude Code..."
mkdir -p ~/.claude
cp "$DOTFILES_DIR/claude/CLAUDE.md" ~/.claude/
cp "$DOTFILES_DIR/claude/settings.json" ~/.claude/

echo "macOS setup complete!"
echo ""
echo "Manual steps:"
echo "1. Login to gh: gh auth login"
echo "2. Setup tailscale: tailscale up"
