# 🚀 Pablo's Ultimate Terminal Cheatsheet

## 🎮 Ghostty Shortcuts (Mac)
| Action | Shortcut | What it does |
|--------|----------|--------------|
| **QUICK TERMINAL** | `Cmd+`` | Show/hide terminal from ANYWHERE! |
| **Split right** | `Cmd+D` | Split window vertically |
| **Split down** | `Cmd+Shift+D` | Split window horizontally |
| **Navigate splits** | `Cmd+←↑→↓` | Move between splits |
| **Navigate splits (vim)** | `Cmd+H/J/K/L` | Vim-style navigation |
| **Navigate splits** | Hover mouse | Focus follows mouse! |
| **Zoom split** | `Cmd+Shift+Z` | Focus on one split |
| **Equalize splits** | `Cmd+Shift+E` | Make splits equal size |
| **New tab** | `Cmd+T` | Create new tab |
| **Switch tabs** | `Cmd+Shift+←/→` | Previous/next tab |
| **Jump to tab** | `Cmd+[1-9]` | Go directly to tab |
| **New window** | `Cmd+Shift+N` | Create new window |
| **Clear screen** | `Cmd+K` | Clear terminal |
| **Fullscreen** | `Cmd+F` | Toggle fullscreen |
| **Reload config** | `Cmd+R` | Apply config changes |
| **Inspector** | `Cmd+I` | Debug terminal |
| **Font bigger** | `Cmd++` | Increase font size |
| **Font smaller** | `Cmd+-` | Decrease font size |
| **Reset font** | `Cmd+0` | Reset to default size |
| **Close split/tab** | `Cmd+W` | Close current split/tab |
| **Find in terminal** | `Cmd+F` | Search text |
| **Find next/prev** | `Cmd+G/Shift+G` | Navigate search |

## ⚡ Custom Keybindings (Your Secret Weapons!)
| Action | Shortcut | What it does |
|--------|----------|--------------|
| **Find & Edit File** | `Ctrl+F` | Find file with fzf and open in editor |
| **Interactive Git Status** | `Ctrl+G` | See git changes, stage files |
| **File Search** | `Ctrl+T` | Find any file with preview |
| **History Search** | `Ctrl+R` | Fuzzy search command history |
| **Directory Jump** | `Alt+C` | cd to any directory |
| **Kill Process** | `Ctrl+P` | Find and kill processes |
| **Recent Directories** | `Alt+D` | Interactive directory jump (zi) |
| **Add Sudo** | `ESC ESC` | Prepend sudo to command |
| **Smart History** | `↑/↓` | Search history by prefix |

## 🎹 TMUX-Style Commands (Cmd+B prefix)
| Action | Keys | What it does |
|--------|------|--------------|
| **New tab** | `Cmd+B` then `C` | Create tab |
| **New window** | `Cmd+B` then `N` | Create window |
| **Split right** | `Cmd+B` then `\` | Vertical split |
| **Split down** | `Cmd+B` then `-` | Horizontal split |
| **Close** | `Cmd+B` then `X` | Close current |
| **Zoom toggle** | `Cmd+B` then `Z` | Zoom/unzoom |
| **Equalize** | `Cmd+B` then `E` | Equal split sizes |
| **Go to tab 1-5** | `Cmd+B` then `1-5` | Jump to tab |
| **Navigate** | `Cmd+B` then `H/J/K/L` | Vim-style navigation |

## 📁 File Navigation Magic
| Command | What it does | Example |
|---------|--------------|---------|
| **`eza`** | Beautiful ls replacement | `eza -la --icons --git` |
| **`ls`** | Aliased to eza | `ls` = `eza --icons` |
| **`ll`** | Long format with git | `ll` shows permissions + git |
| **`la`** | All files | `la` shows hidden files |
| **`lt`** | Tree view | `lt` shows 2 levels |
| **`z [folder]`** | Jump to any folder | `z down` → ~/Downloads |
| **`zi`** | Interactive folder jump | Select from frecent dirs |
| **`ranger`** | Visual file browser | Arrow keys to navigate |
| **`broot`** | Interactive tree | Type to filter |
| **`fd [name]`** | Find files fast | `fd "*.png"` |
| **`fzf`** | Fuzzy find anything | `vim $(fzf)` |
| **`tree`** | Show directory tree | `tree -L 2` |

## 🎨 Modern CLI Replacements
| Old Command | New Command | Why It's Better |
|-------------|-------------|-----------------|
| `cat` | `bat` | Syntax highlighting, line numbers |
| `ls` | `eza` | Icons, git status, better sorting |
| `find` | `fd` | 5x faster, intuitive syntax |
| `grep` | `rg` (ripgrep) | Blazing fast, respects .gitignore |
| `cd` | `z` | Learns your habits, fuzzy matching |
| `top` | `btop` | Beautiful graphs, mouse support |
| `ps` | `procs` | Tree view, better formatting |
| `du` | `dust` | Visual size bars |
| `df` | `duf` | Colorful, grouped output |
| `man` | `tldr` | Examples first |
| `diff` | `delta` | Side-by-side, syntax highlighted |
| `dig` | `dog` | Colorful DNS queries |
| `ping` | `gping` | Graph your latency |

## 🎯 Custom Functions & Aliases
| Command | What it does | Example |
|---------|--------------|---------|
| **`mkcd`** | Make dir and enter it | `mkcd new-project` |
| **`backup`** | Backup with timestamp | `backup important.txt` |
| **`extract`** | Extract any archive | `extract file.zip` |
| **`ginit`** | Init git with .gitignore | Creates README & .gitignore |
| **`targz`** | Create tar.gz | `targz folder/` |
| **`note`** | Add quick note | `note "remember this"` |
| **`notes`** | View all notes | Shows ~/notes.txt |
| **`weather`** | Get weather | `weather Tokyo` |
| **`cht`** | Command cheatsheet | `cht grep` |
| **`reload`** | Reload zsh config | Alias for `source ~/.zshrc` |
| **`zshrc`** | Edit zsh config | Opens in your editor |
| **`gw`** | Git worktree switch | Switch between worktrees |
| **`glog`** | Pretty git log | Colorful graph view |

## 🎨 Fun & Visual Commands
| Command | What it does |
|---------|--------------|
| **`cmatrix`** | Matrix rain animation |
| **`pipes-sh`** | Animated pipes |
| **`sl`** | Train animation (typo punishment!) |
| **`asciiquarium`** | Fish tank in terminal |
| **`neofetch`** | System info + logo |
| **`pfetch`** | Minimal system info |
| **`figlet [text]`** | Big ASCII text |
| **`toilet [text]`** | Colorful ASCII text |
| **`lolcat`** | Rainbow colors |
| **`fortune \| cowsay \| lolcat`** | Rainbow cow wisdom |
| **`fortune \| ponysay \| lolcat`** | Rainbow pony wisdom |
| **`tty-clock -c -C 4`** | Digital clock |
| **`cava`** | Audio visualizer |
| **`neko`** | Cat chases cursor |
| **`genact`** | Fake Hollywood hacking |
| **`hollywood`** | Hacker movie mode |
| **`no-more-secrets`** | Text decryption effect |
| **`bb`** | ASCII art demo |

## 🔥 Git Commands & Shortcuts
| Command | What it does |
|---------|--------------|
| **`lazygit`** | Visual git interface (BEST!) |
| **`gl`** | Alias for lazygit |
| **`tig`** | Text git interface |
| **`git add -p`** | Interactive staging |
| **`delta`** | Beautiful diffs |
| **`gs`** | git status |
| **`ga`** | git add |
| **`gaa`** | git add . |
| **`gc`** | git commit |
| **`gcm`** | git commit -m |
| **`gp`** | git push |
| **`gpl`** | git pull |
| **`gco`** | git checkout |
| **`gb`** | git branch |
| **`glog`** | Pretty git log with graph |
| **`gdiff`** | git diff with colors |
| **`gw`** | Switch git worktrees |

## 🛠️ System & Monitoring
| Command | What it does |
|---------|--------------|
| **`btop`** | Beautiful system monitor (press 'p' for themes!) |
| **`htop`** | Classic system monitor |
| **`duf`** | Disk usage (pretty) |
| **`dust`** | Directory sizes with bars |
| **`procs`** | Better ps with tree view |
| **`speedtest-cli`** | Internet speed test |
| **`mtr [host]`** | Better traceroute |
| **`gping [host]`** | Ping with graph |
| **`bandwhich`** | Network usage by process |

## 🔍 Search & Find
| Command | What it does | Example |
|---------|--------------|---------|
| **`rg [text]`** | Ripgrep - fast search | `rg "TODO"` |
| **`fd [name]`** | Find files | `fd "*.js"` |
| **`sd [old] [new]`** | Find & replace | `sd "foo" "bar" file.txt` |
| **`fzf`** | Fuzzy finder | `vim $(fzf)` |
| **`fselect`** | SQL for files! | `fselect size, path from /tmp` |

## 🌐 Network Tools
| Command | What it does |
|---------|--------------|
| **`myip`** | Show public IP |
| **`localip`** | Show local IP |
| **`ports`** | Show listening ports |
| **`serve`** | Python HTTP server on :8000 |
| **`servephp`** | PHP server on :8000 |
| **`http`** | HTTPie for API testing |
| **`speedtest`** | Test internet speed |
| **`mosh`** | Better SSH for bad connections |
| **`dog`** | Colorful DNS lookups |
| **`gping`** | Visual ping |

## 🖼️ Image & Media Tools
| Command | What it does | Example |
|---------|--------------|---------|
| **`pngquant`** | Compress PNG | `pngquant *.png` |
| **`jpegoptim`** | Compress JPEG | `jpegoptim *.jpg` |
| **`convert`** | ImageMagick | `convert input.png output.jpg` |
| **`mogrify`** | Batch convert | `mogrify -resize 50% *.jpg` |
| **`gifski`** | Create GIF | `gifski -o out.gif *.png` |
| **`ffmpeg`** | Video Swiss knife | `ffmpeg -i in.mp4 out.gif` |
| **`exiftool`** | View/edit metadata | `exiftool image.jpg` |
| **`imageoptim-cli`** | Optimize images | `imageoptim *.png` |

## ⌨️ Terminal Shortcuts
| Shortcut | What it does |
|----------|--------------|
| **`Ctrl+R`** | Search command history (with fzf!) |
| **`Ctrl+A`** | Go to line start |
| **`Ctrl+E`** | Go to line end |
| **`Ctrl+W`** | Delete word backward |
| **`Ctrl+U`** | Clear line |
| **`Ctrl+L`** | Clear screen |
| **`Ctrl+C`** | Cancel command |
| **`Ctrl+Z`** | Suspend process |
| **`Ctrl+D`** | Exit/logout |
| **`Alt+←/→`** | Move by word |
| **`Alt+.`** | Insert last argument |
| **`!!`** | Run last command |
| **`!$`** | Last argument of previous command |
| **`!*`** | All arguments of previous command |
| **`^old^new`** | Replace in last command |

## 🎯 Quick Commands
```bash
# Weather
weather                    # Local weather
weather Tokyo             # Weather for city
curl wttr.in/Moon        # Moon phase

# Cheatsheets
cht [command]            # Cheatsheet for command
tldr [command]           # Quick examples
man [command]            # Full manual

# Quick servers
serve                    # Python HTTP server :8000
servephp                 # PHP server :8000

# System info
myip                     # Public IP
localip                  # Local IP
ports                    # Open ports
speedtest                # Internet speed

# Fun one-liners
fortune | cowsay | lolcat
figlet "HELLO" | lolcat
curl parrot.live         # Party parrot
curl rate.sx/btc         # Bitcoin price
```

## 🌟 Starship Prompt Icons
| Icon | What it Means |
|------|---------------|
| `📁 ~/Projects` | Current directory |
| ` main` | Git branch |
| `✅` | Files staged |
| `📝` | Files modified |
| `❓` | Untracked files |
| `*` | Stashed changes |
| `↑` | Ahead of remote |
| `↓` | Behind remote |
| `↕` | Diverged from remote |
| `❯` (green) | Last command succeeded |
| `❯` (red) | Last command failed |
| `took 2s` | Command duration |

## 💡 Pro Tips
| Feature | How to Use |
|---------|------------|
| **Auto-suggestions** | Gray text appears → press `→` to accept |
| **Syntax highlighting** | Green = valid, Red = invalid command |
| **History search** | Type start of command → press `↑` |
| **Quick edit** | `Ctrl+F` to find and edit any file |
| **Git status** | `Ctrl+G` for interactive git status |
| **Process kill** | `Ctrl+P` to find and kill process |
| **Directory jump** | `z part_of_name` jumps to directory |
| **Command fix** | Type `fuck` after any failed command |
| **Quick notes** | `note "text"` saves timestamped notes |

## 🆘 Troubleshooting
| Issue | Solution |
|-------|----------|
| Command not found | Try `brew install [command]` |
| Slow terminal | Check for NVM in .zshrc (should be lazy loaded) |
| Colors look wrong | Run `export TERM=xterm-256color` |
| Can't see icons | Install a Nerd Font |
| FZF not working | Run `$(brew --prefix)/opt/fzf/install` |

## 📚 Learning Path
1. **Week 1**: Master `z`, `fzf`, and `lazygit`
2. **Week 2**: Learn keybindings (Ctrl+F, Ctrl+G, Ctrl+R)
3. **Week 3**: Replace habits (use `eza` not `ls`, `bat` not `cat`)
4. **Week 4**: Explore fun commands and customization

## 🎓 Remember
- Type `cheat` for interactive menu
- Type `help` or `?` as shortcuts
- Your config files:
  - `~/.zshrc` - Shell config
  - `~/.config/starship.toml` - Prompt
  - `~/.config/ghostty/config` - Terminal
  - `~/.Brewfile` - Installed tools
