# Dotfiles

Cross-platform dotfiles for macOS, Linux, and Windows.

## Quick Start

```bash
git clone https://github.com/louis030195/dotfiles ~/Documents/dotfiles
cd ~/Documents/dotfiles && ./install.sh
```

### Windows (Git Bash)

Run from Git Bash (not PowerShell/CMD):
```bash
git clone https://github.com/louis030195/dotfiles ~/Documents/dotfiles
cd ~/Documents/dotfiles && ./install.sh
```

## What Gets Installed

### Apps (via package manager)
- **Terminal**: WezTerm, MSYS2 (Windows)
- **Editors**: Zed, Cursor, Helix
- **Dev Tools**: Git, Rust, Node.js, Python, GitHub CLI
- **AI**: Claude Desktop

### Configs
- Shell: `.bashrc`, `.bash_profile`, `.aliases`, `.exports`
- Git: `.gitignore_global`, user config
- WezTerm: `wezterm.lua`
- Editors: Zed, Cursor, Helix settings
- Claude Code: `CLAUDE.md`, `settings.json`

### Repos
Clones repos listed in `repos.txt` to `~/Documents/`.

## Post-Install

1. Login to GitHub CLI: `gh auth login`
2. (Optional) Setup Tailscale: `tailscale up`

## Structure

```
dotfiles/
+-- install.sh          # Main installer (detects OS)
+-- install-mac.sh      # macOS-specific setup
+-- install-linux.sh    # Linux-specific setup
+-- install-windows.sh  # Windows-specific setup
+-- clone-repos.sh      # Clones repos from repos.txt
+-- repos.txt           # List of repos to clone
+-- shell/              # Shell configs
+-- git/                # Git configs
+-- wezterm/            # WezTerm config
+-- helix/              # Helix editor config
+-- claude/             # Claude Code config
+-- editors/            # Editor configs (Zed, Cursor)
```
