#!/bin/bash

apt install -y wget curl tmux
# Rust / Cargo
curl https://sh.rustup.rs -sSf | sh
# Alacritty
cargo install alacritty

mkdir -p $HOME/binaries
cp .tmux.conf .gitignore $HOME
wget https://github.com/jgraph/drawio-desktop/releases/download/v13.6.2/draw.io-x86_64-13.6.2.AppImage -O $HOME/binaries
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.8.12/Obsidian-0.8.12.AppImage -O $HOME/binaries
