#!/bin/bash
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

MY_HOME=/home/louis
apt install -y build-essential cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 git wget curl tmux vim htop
# Rust / Cargo
curl https://sh.rustup.rs -sSf | sh -- -y
source $MY_HOME/.cargo/env
# Alacritty
cargo install alacritty

mkdir $MY_HOME/binaries || true
cp .tmux.conf .gitignore .alacritty.yml $MY_HOME
wget https://github.com/jgraph/drawio-desktop/releases/download/v13.6.2/draw.io-x86_64-13.6.2.AppImage -O $MY_HOME/binaries/draw.io.AppImage
chmod +x $MY_HOME/binaries/draw.io.AppImage
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v0.8.12/Obsidian-0.8.12.AppImage -O $MY_HOME/binaries/Obsidian.AppImage
chmod +x $MY_HOME/binaries/Obsidian.AppImage
wget https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage -O $MY_HOME/binaries/UnityHub.AppImage
chmod +x $MY_HOME/binaries/UnityHub.AppImage

echo "DON'T FORGET TO INSTALL THE MOST IMPORTANT THING: DOCKER (MANUALLY IS SAFER)"
