#!/bin/bash
echo "🚀 Installing Pablo's Dotfiles..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install all packages from Brewfile
echo "Installing packages..."
brew bundle

# Create directories
mkdir -p ~/.config/{bat,btop,lazygit,ghostty}
mkdir -p ~/bin

# Symlink files
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
ln -sf $(pwd)/.npmrc ~/.npmrc
ln -sf $(pwd)/.fdignore ~/.fdignore
ln -sf $(pwd)/.ripgreprc ~/.ripgreprc
ln -sf $(pwd)/terminal-cheatsheet.md ~/terminal-cheatsheet.md

# Symlink configs
ln -sf $(pwd)/.config/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/.config/bat/config ~/.config/bat/config
ln -sf $(pwd)/.config/btop/btop.conf ~/.config/btop/btop.conf
ln -sf $(pwd)/.config/lazygit/config.yml ~/.config/lazygit/config.yml

# Ghostty special location
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
ln -sf $(pwd)/.config/ghostty/config "$GHOSTTY_DIR/config"

# Symlink bin
ln -sf $(pwd)/bin/cheat ~/bin/cheat
chmod +x ~/bin/cheat

echo "✅ Done! Restart your terminal."
