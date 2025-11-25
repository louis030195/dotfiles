#!/usr/bin/env bash
# Windows setup - run from Git Bash

echo "=== Windows Setup ==="

# Install apps via winget
if command -v winget &> /dev/null; then
    echo "Installing apps via winget..."
    
    # Terminal & Shell
    winget install --id=wez.wezterm -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=MSYS2.MSYS2 -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    
    # Editors
    winget install --id=Zed.Zed -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Anysphere.Cursor -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Helix.Helix -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    
    # AI
    winget install --id=Anthropic.Claude -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    
    # Dev tools
    winget install --id=Git.Git -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Rustlang.Rustup -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Python.Python.3.12 -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=GitHub.cli -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    
    # Utils
    winget install --id=tailscale.tailscale -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Obsidian.Obsidian -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Discord.Discord -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=SlackTechnologies.Slack -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Google.Chrome -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
else
    echo "winget not found - install Windows App Installer from Microsoft Store"
fi

# Initialize rust
rustup-init -y 2>/dev/null || true

# Install claude code
npm install -g @anthropic-ai/claude-code 2>/dev/null || true

# Setup Zed config
echo "Setting up Zed..."
ZED_CONFIG_DIR="$APPDATA/Zed"
mkdir -p "$ZED_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/zed/settings.json" "$ZED_CONFIG_DIR/"

# Setup Cursor config
echo "Setting up Cursor..."
CURSOR_CONFIG_DIR="$APPDATA/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/cursor/settings.json" "$CURSOR_CONFIG_DIR/"
cp "$DOTFILES_DIR/editors/cursor/keybindings.json" "$CURSOR_CONFIG_DIR/"

# Setup Helix config
echo "Setting up Helix..."
HELIX_CONFIG_DIR="$APPDATA/helix"
mkdir -p "$HELIX_CONFIG_DIR"
cp "$DOTFILES_DIR/helix/config.toml" "$HELIX_CONFIG_DIR/"

# Setup Claude Code
echo "Setting up Claude Code..."
mkdir -p ~/.claude
cp "$DOTFILES_DIR/claude/CLAUDE.md" ~/.claude/
cp "$DOTFILES_DIR/claude/settings.json" ~/.claude/

echo "Windows setup complete!"
echo ""
echo "Manual steps:"
echo "1. Run 'rustup default stable' after restart"
echo "2. Login to gh: gh auth login"
echo "3. Setup tailscale: tailscale up"
