# 🚀 Pablo's Terminal Paradise

> *"Why have a boring terminal when you can have a PARTY in your shell?"* 🎉

Welcome to my personal macOS terminal setup - where productivity meets fun, and every command feels like magic ✨

![Terminal Demo](https://user-images.githubusercontent.com/yourusername/terminal-demo.gif)
*↑ This is what you're getting (GIF coming soon)*

## 🎯 What's This All About?

I got tired of the default Terminal.app looking like it's from 1984, so I built this. It's my complete dev environment optimized for building Svelte apps and having a good time while doing it.

## ⚡ Quick Start (30 seconds, seriously)

```bash
# Clone this bad boy
git clone https://github.com/pibulus/mac-terminal-paradise.git ~/dotfiles

# Run the magic installer
cd ~/dotfiles && ./install.sh

# Restart your terminal and... 🤯
```

## 🎮 What You Get

### The Cool Stuff
- **Ghostty Terminal** - Press `Cmd+`\` from ANYWHERE to summon it (game changer!)
- **Beautiful Shell** - With icons, colors, and git info that doesn't suck
- **50+ Modern Tools** - Because `ls` is boring when you can have `eza` with icons
- **Interactive Cheat Menu** - Type `cheat` and never forget a command again
- **ASCII Aquarium** - Because why not? 🐠

### The Productive Stuff
- **Smart Navigation** - Type `z proj` to jump to your projects folder
- **Git Superpowers** - `lazygit` for visual git, custom shortcuts for speed
- **Fuzzy Everything** - Find files, commands, directories with fuzzy search
- **Custom Keybindings** - `Ctrl+F` to find & edit files, `Ctrl+G` for git status
- **Svelte Optimized** - Aliases and tools specifically for web dev

## 🛠️ The Stack

| Old & Busted | New Hotness | Why It's Better |
|--------------|-------------|-----------------|
| `cat` | `bat` | Syntax highlighting! |
| `ls` | `eza` | Icons + Git status! |
| `find` | `fd` | 5x faster + intuitive! |
| `grep` | `ripgrep` | Blazing fast! |
| `cd` | `z` | Teleport to directories! |
| `top` | `btop` | Actually readable! |

Plus: tmux, fzf, delta, glow, and a bunch more...

## 📚 Learning This Setup

After installing, type:
- `cheat` - Interactive guide to everything
- `help` - Same thing (I forget which one I want to type)
- `?` - Also the same thing (really forgetful)

The cheat menu is INTERACTIVE - it'll teach you everything!

## 🎨 Make It Yours

### Change Theme
1. **Terminal**: Edit `.config/ghostty/config` → `theme = `
2. **System Monitor**: Run `btop` and press `p`
3. **Prompt**: It's already perfect, why change it?

### Add Your Tools
1. Add to `Brewfile`
2. Run `brew bundle`
3. Profit 💰

## 🚨 Requirements

- macOS (tested on Sonoma)
- [Homebrew](https://brew.sh) (installer will add it if missing)
- 15 minutes to spare
- Desire for a better life

## 🤔 FAQ

**Q: Will this mess up my current setup?**  
A: Nah, the installer backs up everything first.

**Q: Can I uninstall it?**  
A: Why would you want to? But yes, just restore from the backup folder.

**Q: Does it work on Linux?**  
A: Not yet, but PRs welcome!

**Q: Is it fast?**  
A: Faster than your current setup, guaranteed.

## 🎯 Pro Tips

1. **Quick Terminal**: `Cmd+`\` is life-changing. Use it.
2. **Navigation**: Forget `cd`. Use `z` and thank me later.
3. **Git**: Just type `lazygit`. Trust me.
4. **Fun Break**: Try `cmatrix` or `asciiquarium`

## 📸 Screenshots

### The Terminal
![Ghostty Terminal](https://user-images.githubusercontent.com/yourusername/ghostty.png)

### Interactive Cheat Menu
![Cheat Menu](https://user-images.githubusercontent.com/yourusername/cheat-menu.png)

### System Monitoring with btop
![btop](https://user-images.githubusercontent.com/yourusername/btop.png)

## 🤝 Contributing

Found a cool tool? Fixed something? Send a PR! 

Just keep it fun and useful.

## 📝 License

MIT - Do whatever you want with it!

---

<div align="center">
  
### Built with ❤️ and too much ☕ by Pablo

*If this made your terminal awesome, throw a ⭐ on the repo!*

**[Download](https://github.com/pibulus/dotfiles/archive/main.zip)** • **[Issues](https://github.com/pibulus/dotfiles/issues)** • **[My Website](https://yoursite.com)**

</div>
