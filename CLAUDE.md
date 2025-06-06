# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is Pablo's personal macOS dotfiles repository - a comprehensive terminal setup that transforms the default macOS terminal experience into a modern, productive development environment. The repository focuses on:

- **Modern CLI tools**: Replacing traditional commands (ls → eza, cat → bat, etc.)
- **Interactive terminal experience**: Custom cheat menu system and visual tools
- **Svelte/web development optimization**: Tools and aliases specifically for modern web development
- **Ghostty terminal integration**: Advanced terminal emulator with custom shortcuts
- **Git workflow enhancement**: Visual git tools and custom shortcuts

## Key Components

### Main Script: `bin/cheat`
The centerpiece is an interactive bash script that provides:
- Welcome flow for new users with guided tutorials
- Menu-driven interface using `gum` for selection
- Comprehensive command reference organized by category
- Live demonstrations of tools and workflows
- Custom keybinding documentation

### Installation System
- `install.sh`: Symlinks dotfiles and installs Homebrew packages
- `Brewfile`: Contains all Homebrew packages/apps (referenced but not in this directory)
- Backup system for existing configurations

### Documentation
- `README.md`: User-facing documentation with setup instructions
- `terminal-cheatsheet.md`: Comprehensive reference for all shortcuts and commands

## Architecture Notes

### Interactive Menu System
The cheat script uses a modular approach with separate functions for each menu section:
- `show_menu()`: Main navigation hub
- Individual display functions (e.g., `show_git_commands()`, `show_modern_tools()`)
- Tutorial functions that provide hands-on learning
- Power tip system with randomized helpful hints

### Tool Integration Philosophy
The setup follows a "modern replacement" philosophy:
- Every traditional Unix tool has a modern, enhanced alternative
- Tools are configured to work together seamlessly
- Custom keybindings bridge different tools into unified workflows

## Common Development Tasks

### Working with the cheat script
- The script is designed to be self-documenting and educational
- When modifying, maintain the gum-based styling consistency
- Add new tools to appropriate sections (modern tools, git commands, etc.)
- Keep demonstrations short but impactful

### Adding new tools
1. Add to the appropriate Brewfile (not in this directory structure)
2. Update the relevant section in the cheat script
3. Add demonstrations if the tool is visual
4. Update terminal-cheatsheet.md if it has unique shortcuts

### Testing changes
- Test the cheat script interactively: `./bin/cheat`
- Verify all gum style blocks render correctly
- Test any new demonstrations or tutorials
- Ensure welcome flow still works for new users

## File Structure Notes

- `/bin/cheat`: Single executable script containing all menu logic
- Configuration files are managed via symlinks in install.sh
- The script expects certain tools to be installed (gum, figlet, lolcat, etc.)
- First-run detection uses `~/.cheat_welcomed` file

## Key Dependencies

The cheat script expects these tools to be available:
- `gum`: Interactive prompts and styling
- `figlet` + `lolcat`: ASCII art with colors
- `fzf`: Fuzzy finding (used in demonstrations)
- `bat`, `eza`, `btop`: Modern CLI tools being demonstrated
- `lazygit`: Git UI tool that's heavily featured

When modifying the script, always check tool availability before using them in demonstrations.