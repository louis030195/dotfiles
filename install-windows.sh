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
    winget install --id=Google.Chrome -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true

    # CLI tools
    winget install --id=jqlang.jq -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Oven-sh.Bun -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Supabase.CLI -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Microsoft.AzureCLI -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Vercel.Vercel -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Docker.DockerDesktop -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
    winget install --id=Tailscale.Tailscale -e --accept-source-agreements --accept-package-agreements 2>/dev/null || true
else
    echo "winget not found - install Windows App Installer from Microsoft Store"
fi

# Initialize rust (use full path for Windows)
if [ -f "$USERPROFILE/.cargo/bin/rustup-init.exe" ]; then
    "$USERPROFILE/.cargo/bin/rustup-init.exe" -y 2>/dev/null || true
elif command -v rustup-init &> /dev/null; then
    rustup-init -y 2>/dev/null || true
fi

# Set rustup default
if [ -f "$USERPROFILE/.cargo/bin/rustup.exe" ]; then
    "$USERPROFILE/.cargo/bin/rustup.exe" default stable 2>/dev/null || true
fi

# Install claude code
npm install -g @anthropic-ai/claude-code 2>/dev/null || true

# Setup Zed config
echo "Setting up Zed..."
ZED_CONFIG_DIR="$APPDATA/Zed"
mkdir -p "$ZED_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/zed/settings.json" "$ZED_CONFIG_DIR/" 2>/dev/null || true

# Setup Cursor config
echo "Setting up Cursor..."
CURSOR_CONFIG_DIR="$APPDATA/Cursor/User"
mkdir -p "$CURSOR_CONFIG_DIR"
cp "$DOTFILES_DIR/editors/cursor/settings.json" "$CURSOR_CONFIG_DIR/" 2>/dev/null || true
cp "$DOTFILES_DIR/editors/cursor/keybindings.json" "$CURSOR_CONFIG_DIR/" 2>/dev/null || true

# Setup Helix config
echo "Setting up Helix..."
HELIX_CONFIG_DIR="$APPDATA/helix"
mkdir -p "$HELIX_CONFIG_DIR"
cp "$DOTFILES_DIR/helix/config.toml" "$HELIX_CONFIG_DIR/" 2>/dev/null || true

# Setup Claude Code
echo "Setting up Claude Code..."
mkdir -p ~/.claude
cp "$DOTFILES_DIR/claude/CLAUDE.md" ~/.claude/ 2>/dev/null || true
cp "$DOTFILES_DIR/claude/settings.json" ~/.claude/ 2>/dev/null || true

echo "Windows setup complete!"
echo ""
echo "Manual steps:"
echo "1. Login to gh: gh auth login"
echo "2. Setup tailscale: tailscale up"
