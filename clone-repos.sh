#!/usr/bin/env bash
# Clone repos from repos.txt to ~/Documents

DOCS_DIR="$HOME/Documents"

echo "Cloning repos to $DOCS_DIR..."

while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    
    repo="$line"
    repo_name=$(basename "$repo")
    target_dir="$DOCS_DIR/$repo_name"
    
    if [ -d "$target_dir" ]; then
        echo "Skipping $repo_name (already exists)"
    else
        echo "Cloning $repo..."
        git clone "git@github.com:$repo.git" "$target_dir" || \
        git clone "https://github.com/$repo.git" "$target_dir"
    fi
done < "$DOTFILES_DIR/repos.txt"

echo "Done cloning repos!"
