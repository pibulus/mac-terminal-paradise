#!/bin/zsh
# ============================================================================
# 🎯 Pablo's Ultimate Zsh Configuration - EPIC + TERMINAL POWER ENHANCED
# ============================================================================

# ============================================================================
# 🔐 Terminal Power - API Keys & Environment (Load Early)
# ============================================================================

# Load API keys from secure config file (with permission check)
if [[ -f "$HOME/.config/api_keys" && -r "$HOME/.config/api_keys" ]]; then
    source "$HOME/.config/api_keys"
fi

# ============================================================================
# 🛠️ Development Tools - CONSOLIDATED
# ============================================================================

# Fix character encoding for figlet+lolcat (was broken)
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# FIX: Disable grep->rg alias that breaks Claude Code
unalias grep 2>/dev/null || true
unalias egrep 2>/dev/null || true
unalias fgrep 2>/dev/null || true

# Force grep to be the real grep
alias grep='/usr/bin/grep'
alias egrep='/usr/bin/grep -E'
alias fgrep='/usr/bin/grep -F'

# Claude's bulletproof radio
alias radio="~/.claude/scripts/radio.sh"

# Development tools initialization starts here

# Homebrew - SINGLE INITIALIZATION (Apple Silicon and Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# NVM - LAZY LOADING ONLY (for fast startup)
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
    unset -f node npm npx nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Lazy load functions
node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }
nvm() { lazy_load_nvm; nvm "$@"; }

# ============================================================================
# 🚀 PATH CONFIGURATION - SIMPLIFIED
# ============================================================================

# Prevent PATH duplicates
typeset -U PATH

# Simple, direct PATH setup
export PATH="$HOME/.deno/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.npm-global/bin:$HOME/.nvm/versions/node/v20.9.0/bin:$PATH"

# Add Python user bin if it exists
if command -v python3 >/dev/null 2>&1; then
    PYTHON_USER_BASE=$(python3 -m site --user-base 2>/dev/null)
    if [[ -n "$PYTHON_USER_BASE" && -d "$PYTHON_USER_BASE/bin" ]]; then
        export PATH="$PYTHON_USER_BASE/bin:$PATH"
    fi
fi

# ============================================================================
# 🎨 Development Environment
# ============================================================================

# Python
alias pip=pip3
alias python=python3

# Editor
export EDITOR='micro'
export VISUAL='micro'

# Neko
export NEKOPATH=/opt/homebrew/lib/neko

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Empty because we use Starship

# Plugins - order matters! zsh-syntax-highlighting must be LAST
plugins=(
    git                           # Git shortcuts
    fzf                          # Fuzzy finding
    extract                      # Extract any archive with 'extract'
    copypath                     # Copy current path
    copyfile                     # Copy file contents
    web-search                   # Search from terminal
    sudo                         # Press ESC twice to add sudo
    command-not-found            # Suggests packages to install
    zsh-autosuggestions          # Fish-like suggestions
    history-substring-search     # Arrow key history search (FIXED!)
    zsh-syntax-highlighting      # MUST BE LAST!
)

# Source Oh My Zsh ONLY ONCE after plugins are defined
source $ZSH/oh-my-zsh.sh

# Homebrew command-not-found (only if brew is available)
if command -v brew >/dev/null 2>&1; then
    [[ -f "$(brew --prefix)/etc/profile.d/command-not-found.zsh" ]] && source "$(brew --prefix)/etc/profile.d/command-not-found.zsh"
fi

# ============================================================================
# 🌈 STARSHIP THEME SYSTEM - SIMPLIFIED
# ============================================================================

# Working themes only - no more broken functions

# ============================================================================
# 🚀 Initialize External Tools
# ============================================================================

# Starship prompt (with fixed config)
if command -v starship >/dev/null 2>&1; then
    # Create minimal config if it doesn't exist to prevent docker errors
    if [[ ! -f "$HOME/.config/starship.toml" ]]; then
        mkdir -p "$HOME/.config"
        cat > "$HOME/.config/starship.toml" << 'EOF'
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$cmd_duration\
$line_break\
$character"""

[directory]
style = "blue bold"
truncation_length = 3

[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
EOF
    fi
    eval "$(starship init zsh)"
fi

# Zoxide - smarter cd (replaces z plugin)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# The Fuck - fix command typos
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# Direnv - per-project environments
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# Better LS colors - Cohesive Lo-Fi Rainbow 🌈✨
# Smooth spectrum: Purple → Pink → Yellow → Blue (cute retro vibes)
export LS_COLORS='di=01;38;5;141:ln=01;38;5;218:ex=01;38;5;152:*.py=01;38;5;221:*.js=01;38;5;221:*.json=01;38;5;117:*.md=01;38;5;213:*.txt=00;38;5;230:*.log=00;38;5;240:*.zip=01;38;5;135:*.tar=01;38;5;135:*.gz=01;38;5;135:*.sh=01;38;5;152:*.zsh=01;38;5;152:*.rb=01;38;5;221:*.go=01;38;5;117:*.rs=01;38;5;221:*.cpp=01;38;5;117:*.c=01;38;5;117:*.h=01;38;5;218:*.css=01;38;5;218:*.html=01;38;5;221:*.png=01;38;5;225:*.jpg=01;38;5;225:*.gif=01;38;5;225:*.dmg=01;38;5;219:*.pkg=01;38;5;219:or=01;38;5;217:mi=01;38;5;174'

# macOS specific LS colors (BSD ls) - Lo-Fi Rainbow 🌈✨  
# F=magenta(purple), G=cyan(blue), D=brown(yellow), x=default bg
export LSCOLORS='FxFxGxDxBxegedabagaced'

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --level=2 {}'"

# ============================================================================
# 🎨 Smart Aliases - Only create if command exists
# ============================================================================

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Quick jump to common directories
alias proj='cd ~/projects/active'
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias tools='cd ~/projects/tools'

# Create a projects menu
projects() {
    echo "📁 Your Projects:"
    echo "────────────────"
    ls -1 ~/projects/active/ 2>/dev/null || echo "No active projects found"
    echo ""
    echo "Type: cd ~/projects/active/<project-name>"
}

# Better ls with eza - Final aliases set at end of config to override any conflicts

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Safer rm alternatives (opt-in, not forced)
command -v trash >/dev/null 2>&1 && alias trash='trash'
alias rmi='rm -i'      # Interactive rm when you want it
alias rmf='rm -rf'     # Force remove (use with caution!)

# Modern replacements - USE SEPARATE ALIASES TO PRESERVE STANDARDS
# These tools are available but don't override the originals
command -v bat >/dev/null 2>&1 && alias bcat='bat' && export BAT_THEME="Dracula"
command -v btop >/dev/null 2>&1 && alias btop='btop'
command -v duf >/dev/null 2>&1 && alias duf='duf'
command -v dust >/dev/null 2>&1 && alias dust='dust'
command -v procs >/dev/null 2>&1 && alias procs='procs'
command -v rg >/dev/null 2>&1 && alias rg='rg'
command -v fd >/dev/null 2>&1 && alias fd='fd'
command -v gping >/dev/null 2>&1 && alias gping='gping'
command -v dog >/dev/null 2>&1 && alias dog='dog'

# Convenience aliases for modern tools (opt-in)
alias rgrep='rg'        # Use rgrep for ripgrep
alias fdfind='fd'       # Use fdfind for fd

# Git shortcuts (with safety improvements and COLORS!)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff --color'

# Configure git-delta for beautiful diffs (if available)
if command -v delta >/dev/null 2>&1; then
    alias gd='git diff'  # delta is configured via git config
    alias gdelta='git diff'  # explicit delta alias
    
    # Setup git-delta (run once)
    setup-delta() {
        echo "🎨 Setting up git-delta for beautiful diffs..."
        git config --global core.pager "delta"
        git config --global interactive.diffFilter "delta --color-only"
        git config --global delta.navigate true
        git config --global delta.light false
        git config --global delta.side-by-side true
        echo "✅ Git-delta configured! Try 'gd' or 'git diff' now"
    }
fi
alias glog='git log --oneline --graph --decorate --color'

# Git colors should be set once, not every shell load
# Run this if needed: git config --global color.ui auto

# Git commit guard - DISABLED (doesn't work with Claude's non-interactive environment)
# If you want branch protection, use git hooks or git config instead
# Example: git config --global branch.main.protect true
# Or create a .git/hooks/pre-commit hook in your repos

# Git undo function (safe)
gundo() {
    echo "Select undo type:"
    echo "1) Soft reset (keep changes staged)"
    echo "2) Mixed reset (keep changes unstaged)"
    echo "3) Hard reset (DELETE all changes)"
    read -k1 "?Choice: "
    echo
    case $REPLY in
        1) git reset --soft HEAD~1 && echo "✅ Soft reset completed" ;;
        2) git reset --mixed HEAD~1 && echo "✅ Mixed reset completed" ;;
        3) 
            echo "💥 This will PERMANENTLY DELETE all uncommitted changes!"
            read -q "?Are you absolutely sure? (y/N): "
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git reset --hard HEAD~1 && echo "💥 Hard reset completed"
            else
                echo "Cancelled"
            fi
            ;;
        *) echo "Cancelled" ;;
    esac
}

# Git emergency functions
yikes() {
    local current_branch=$(git branch --show-current 2>/dev/null)
    if [[ -z "$current_branch" ]]; then
        echo "❌ Not in a git repository"
        return 1
    fi
    
    echo "💥 YIKES! This will reset $current_branch to origin/$current_branch"
    echo "⚠️  All local changes will be LOST!"
    read -q "?Are you sure? (y/N): "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git fetch origin && git reset --hard origin/$current_branch && echo "💥 Reset to origin/$current_branch completed"
    else
        echo "Cancelled - crisis averted!"
    fi
}

resurrect() {
    echo "🧟 Git Resurrection - Recent commit history:"
    echo "─────────────────────────────────────────────"
    git reflog --oneline -10
    echo ""
    echo "💡 To resurrect a commit: git checkout <commit-hash>"
    echo "💡 To recover lost work: git cherry-pick <commit-hash>"
    echo "💡 To create new branch: git checkout -b recovered-work <commit-hash>"
}

# GitHub CLI shortcuts (if gh is available)
# NOTE: Can't use gpr as function name - conflicts with git plugin alias
if command -v gh >/dev/null 2>&1; then
    # GitHub aliases that don't conflict
    alias ghpr='gh pr create --web'
    alias ghissue='gh issue create --web'
    alias ghrepo='gh repo view --web'
fi

# Additional git workflow functions (that don't conflict with git plugin)
# NOTE: gwip, gunwip, and gclean already exist in git plugin

gsync() {
    local current_branch=$(git branch --show-current 2>/dev/null)
    echo "🔄 Syncing $current_branch with origin..."
    git fetch origin && git merge origin/$current_branch && echo "✅ Branch synced!"
}

gfresh() {
    echo "🆕 Fresh start - stashing changes, pulling latest, restoring..."
    git stash push -m "Auto-stash before fresh pull $(date +'%Y-%m-%d %H:%M')"
    git pull
    echo "💡 Run 'git stash pop' to restore your changes"
}

# Git workflow helpers
gfix() {
    if [[ -z "$1" ]]; then
        echo "Usage: gfix <commit-message>"
        echo "Creates a fixup commit for quick fixes"
        return 1
    fi
    git add -A && git commit -m "fixup: $*" && echo "🔧 Fixup commit created!"
}

gsquash() {
    local count=${1:-2}
    echo "🔄 Interactive squash of last $count commits..."
    git rebase -i HEAD~$count
}

gtrack() {
    local current_branch=$(git branch --show-current 2>/dev/null)
    if [[ -z "$current_branch" ]]; then
        echo "❌ Not in a git repository"
        return 1
    fi
    git branch --set-upstream-to=origin/$current_branch $current_branch
    echo "📡 Branch $current_branch now tracks origin/$current_branch"
}

# Lazygit if available
command -v lazygit >/dev/null 2>&1 && alias gl='lazygit'

# Quick edits
alias zshrc='${EDITOR} ~/.zshrc'
alias zshreload='source ~/.zshrc && echo "✅ Zsh config reloaded!"'
alias reload='source ~/.zshrc && echo "✅ Zsh config reloaded!"'
alias ghosttyconf='${EDITOR} ~/.config/ghostty/config'
alias starshipconf='${EDITOR} ~/.config/starship.toml'
alias brewfile='${EDITOR} ~/.Brewfile'

# Quick servers
alias serve='python3 -m http.server 8000'
alias servephp='php -S localhost:8000'

# Network (with improved security)
alias localip='ipconfig getifaddr en0 2>/dev/null || echo "No network connection"'
command -v speedtest-cli >/dev/null 2>&1 && alias speedtest='speedtest-cli'
alias ports='lsof -PiTCP -sTCP:LISTEN'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Fun stuff (only if installed)
command -v cmatrix >/dev/null 2>&1 && alias matrix='cmatrix -b'
command -v tty-clock >/dev/null 2>&1 && alias clock='tty-clock -c -C 4'
command -v asciiquarium >/dev/null 2>&1 && alias aquarium='asciiquarium'
command -v sl >/dev/null 2>&1 && alias trains='sl'
alias moon='curl -s --connect-timeout 5 --max-time 10 wttr.in/Moon 2>/dev/null || echo "Moon phase service unavailable"'
alias bitcoin='curl -s --connect-timeout 5 --max-time 10 rate.sx/btc 2>/dev/null || echo "Crypto service unavailable"'
alias parrot='curl --connect-timeout 5 --max-time 15 parrot.live 2>/dev/null || echo "Parrot party unavailable"'
alias weather='curl -s --connect-timeout 5 --max-time 10 wttr.in 2>/dev/null || echo "Weather service unavailable"'

# Deno shortcuts
alias deno-version='deno --version'
alias dr='deno run'
alias dt='deno test' 
alias dfmt='deno fmt'
alias dl='deno lint'
alias dc='deno compile'

# Fresh shortcuts
alias fresh='deno run -A --watch=static/,routes/ dev.ts'
alias fresh-init='deno run -A -r https://fresh.deno.dev'

# Simple dinit function
dinit() {
    local name="${1:-deno-project}"
    mkdir -p "$name" && cd "$name"
    echo '{"tasks": {"dev": "deno run --allow-net --watch main.ts"}}' > deno.json
    echo 'console.log("Hello Deno! 🦕");' > main.ts
    echo "✅ Project '$name' created! Run: deno task dev"
}

# ============================================================================
# 🎯 Productivity Functions
# ============================================================================

# Essential utility functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

backup() {
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Backed up to: $1.bak.$(date +%Y%m%d_%H%M%S)"
}

extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick git init with better defaults
ginit() {
    git init
    echo "# ${PWD##*/}" > README.md
    cat > .gitignore << 'EOF'
# System
.DS_Store
*.log

# Dependencies
node_modules/
vendor/

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/

# Build
dist/
build/
*.cache
EOF
    git add .
    git commit -m "Initial commit"
    echo "✅ Git repository initialized with sensible defaults"
}

# Better error recovery - unfuck common mistakes
alias :q='exit'
alias :wq='exit'


# Save current context
now() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Working on: $*" >> ~/.now
    echo "✅ Context saved!"
}

alias whatnow='tail -5 ~/.now'

# Quick notes system
note() {
    echo "$(date +'%Y-%m-%d %H:%M:%S'): $*" >> ~/notes.txt
    echo "✅ Note saved!"
}

notes() {
    if [ -f ~/notes.txt ]; then
        command -v bat >/dev/null 2>&1 && bat ~/notes.txt || cat ~/notes.txt
    else
        echo "No notes yet. Use 'note <text>' to add one!"
    fi
}

# Search notes
notesearch() {
    if [ -f ~/notes.txt ]; then
        grep -i "$1" ~/notes.txt
    else
        echo "No notes file found"
    fi
}

# ============================================================================
# 🚀 TERMINAL POWER INTEGRATION (Conditional - Only if installed)
# ============================================================================

# MCP & AI Tools (PATH-based, clean aliases)
# Only aliases for tools that actually exist
command -v domains >/dev/null && alias domainprice='domains pricing'

# Creative & Utility Pack
command -v weather >/dev/null && alias w='weather'
command -v color-tools >/dev/null && alias colorname='color-tools name'
command -v color-tools >/dev/null && alias colorscheme='color-tools scheme'
command -v color-tools >/dev/null && alias palette='color-tools palette'

# Web APIs (no dependencies, work immediately)
alias qr='function _qr() { curl -s "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$1" -o qr.png && echo "QR code saved as qr.png"; }; _qr'
alias quote='curl -s "https://dummyjson.com/quotes/random" | jq -r ".quote + \" - \" + .author"'
alias shorten='function _shorten() { curl -s "https://is.gd/create.php?format=simple&url=$1"; }; _shorten'
alias uuid='curl -s "https://httpbin.org/uuid" | jq -r ".uuid"'
alias myip='curl -s "https://httpbin.org/ip" | jq -r ".origin"'
alias catfact='curl -s "https://catfact.ninja/fact" | jq -r ".fact"'
alias joke='curl -s "https://official-joke-api.appspot.com/random_joke" | jq -r ".setup + \" \" + .punchline"'

# MCP Help System - Interactive AI Terminal Control
command -v mcphelp >/dev/null && alias mcp='mcphelp'
command -v mcphelp >/dev/null && alias mcpapi='mcphelp api'
command -v mcphelp >/dev/null && alias mcptest='mcphelp test'

# ============================================================================
# 🌸 Backup & Golden State Management (Marie Kondo Approved)
# ============================================================================

# Spark joy with organized backups
backup-zshrc() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    cp ~/.zshrc ~/.backups/zshrc/zshrc.$timestamp
    echo "✨ Zshrc backed up with love"
}

# Update golden state when config sparks maximum joy
# golden-save() {
#     cp ~/.zshrc ~/golden/zshrc.golden
#     cp ~/.config/starship.toml ~/golden/starship.golden 2>/dev/null
#     cd ~/golden && git add . && git commit -m "✨ Golden state updated - $(date +%Y-%m-%d)"
#     echo "🌟 Golden state saved! Your config sparks joy!"
# }

# Restore to golden state when things get messy
golden-restore() {
    cp ~/golden/zshrc.golden ~/.zshrc
    [[ -f ~/golden/starship.golden ]] && cp ~/golden/starship.golden ~/.config/starship.toml
    echo "✨ Restored to golden state! Peace and joy restored"
    echo "🔄 Run: source ~/.zshrc"
}

# Check what's in golden
golden-status() {
    echo "🌟 Golden State Status:"
    cd ~/golden && git status --short
}

# ============================================================================
# 🎯 Help System - Simple and Useful
# ============================================================================

help() {
    echo ""
    echo "  🎸 Pablo's Terminal Commands"
    echo "  ════════════════════════════════════════"
    echo ""
    echo "  📁 FILES & NAVIGATION"
    echo "  mkcd <dir>         Create and enter directory"
    echo "  backup <file>      Backup with timestamp"
    echo "  extract <file>     Extract any archive type"
    echo "  z <partial>        Jump to frecent directory"
    echo "  projects           List active projects"
    echo "  .., ..., ....      Go up 1, 2, 3 directories"
    echo ""
    echo "  🤖 PRODUCTIVITY"
    echo "  claude             AI coding (with sleep check)"
    echo "  note <text>        Quick note to ~/notes.txt"
    echo "  notes              View all notes"
    echo "  now <text>         Save current context"
    echo "  ginit              Start git repo with .gitignore"
    echo "  dinit <name>       Create Deno project"
    echo ""
    echo "  💾 BACKUP & GOLDEN STATE"
    echo "  backup-zshrc       Quick backup with timestamp"
    echo "  # golden-save      Save current as golden (disabled)"
    echo "  golden-restore     Restore from golden"
    echo "  golden-status      Check golden git status"
    echo ""
    echo "  📂 MODERN LS (eza)"
    echo "  ls/l               Icons & colors"
    echo "  ll                 Long list + git"
    echo "  la                 All + hidden"
    echo "  lt                 Tree view"
    echo ""
    echo "  🎮 FUN STUFF"
    echo "  parrot             Dancing ASCII parrot 🦜"
    echo "  matrix             Matrix rain effect"
    echo "  weather            Local forecast"
    echo "  fortune            Random quote"
    echo "  moon               Moon phase"
    echo "  joke, catfact      Random content"
    echo ""
    echo "  🚀 MODERN TOOLS"
    echo "  btop               Better top"
    echo "  bat                Better cat with syntax"
    echo "  rg <text>          Ripgrep search"
    echo "  fd <name>          Find files/dirs"
    echo "  fzf                Fuzzy finder"
    echo "  Ctrl+R             Fuzzy history"
    echo "  Ctrl+T             Fuzzy file search"
    echo "  domains <d>        Check domain availability"
    echo "  sysinfo            System information"
    echo ""
    echo "  💡 Try: tldr <command> for standard command examples"
    echo "      Or: curl cheat.sh/<command> for cheatsheets"
    echo ""
    
    # Git section at the bottom with styling
    if command -v gum >/dev/null 2>&1; then
        echo ""
        echo "  🔨 GIT POWER TOOLS" | gum style --foreground="#ff79c6" --bold
        echo "  ════════════════════════════════════════" | gum style --foreground="#ff79c6"
    elif command -v lolcat >/dev/null 2>&1; then
        echo ""
        echo "  🔨 GIT POWER TOOLS" | lolcat
        echo "  ════════════════════════════════════════" | lolcat
    else
        echo ""
        echo "  🔨 GIT POWER TOOLS"
        echo "  ════════════════════════════════════════"
    fi
    
    echo "  📊 BASIC GIT"
    echo "  gs                 Quick status check"
    echo "  ga                 Stage all changes" 
    echo "  gc/gcm             Commit (interactive/with message)"
    echo "  gp/gpl             Push to remote/Pull from remote"
    echo "  glog               Beautiful commit history"
    echo "  gd                 Diff with colors (uses delta if available)"
    echo "  gb/gco             Branch operations/Checkout"
    echo ""
    echo "  🚨 EMERGENCY TOOLS"
    echo "  gundo              Safe commit undo (with options)"
    echo "  yikes              Reset to origin/main (destructive!)"
    echo "  resurrect          Recover lost commits from reflog"
    echo "  fuck               Fix your last command (thefuck)"
    echo ""
    echo "  🔄 WORKFLOW HELPERS"
    echo "  gwip               Save work in progress (git plugin)"
    echo "  gunwip             Undo WIP commit (git plugin)"
    echo "  gfresh             Stash, pull, ready to restore"
    echo "  gsync              Sync branch with origin"
    echo "  gclean             Clean interactively (git plugin)"
    echo "  gfix <msg>         Quick fixup commit"
    echo "  gsquash [n]        Interactive squash (default: 2)"
    echo "  gtrack             Track upstream branch"
    echo ""
    echo "  🐙 GITHUB TOOLS (gh required)"
    echo "  ghpr               Create pull request in browser"
    echo "  ghissue            Create issue in browser"
    echo "  ghrepo             Open repo in browser"
    echo "  gl                 Launch lazygit TUI"
    echo ""
    echo "  🎨 SETUP"
    echo "  setup-delta        Configure git-delta for beautiful diffs"
    echo ""
}

# Short alias
alias '?'='help'

# Cheat.sh integration - online cheatsheets
cheatsh() {
    if [[ -z "$1" ]]; then
        echo "Usage: cheatsh <command>"
        echo "Example: cheatsh git, cheatsh tar, cheatsh docker"
    else
        curl -s cheat.sh/$1 | less -R
    fi
}

# ============================================================================
# 🚀 CLAUDE CODE MEMORY PROTECTION & FIX
# ============================================================================

# Claude workspace protection
alias claude-home='echo "⚠️  WARNING: Running Claude Code in home directory!" && sleep 2 && claude'
alias claude-safe-workspace='cd ~/projects/scratch && claude'

# ============================================================================
# 🌙 Pablo's Midnight Guardian
# ============================================================================

# Check if it's late
checktime() {
    hour=$(date +%H)
    if (( hour >= 0 && hour <= 5 )); then
        echo "🌙 Pablo, it's $(date +%I:%M%p). Maybe go to sleep?"
        return 0
    fi
    return 1
}

# ============================================================================
# 🛠️ Shell Configuration
# ============================================================================

# History improvements
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY              # Show command with history expansion before running it
setopt INC_APPEND_HISTORY       # Add commands as they are typed, not at shell exit

# Key bindings for productivity
bindkey -e  # Emacs-style bindings

# History search with arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Better word navigation
bindkey "^[[1;3C" forward-word     # Alt+Right
bindkey "^[[1;3D" backward-word    # Alt+Left

# Tab to accept autosuggestions (fixes tab completion)
bindkey '^I' expand-or-complete     # Tab does normal completion
bindkey '^ ' autosuggest-accept      # Ctrl+Space accepts the suggestion
# Alternative: use right arrow to accept (default behavior)

# Shell options for better experience
setopt AUTO_CD              # Just type directory name to cd
setopt AUTO_PUSHD          # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS   # No duplicates in stack
setopt CORRECT             # Spell correction for commands
setopt COMPLETE_IN_WORD    # Complete from both ends of word
setopt GLOB_COMPLETE       # Generate matches for globbing
setopt EXTENDED_GLOB       # Use extended globbing syntax
setopt NO_BEEP            # No beeping
setopt IGNORE_EOF          # Ctrl+D won't exit shell (use 'exit' instead)

# Better completion
autoload -U compinit && compinit -d ~/.zcompdump
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# Enable tab completion for aliases
setopt COMPLETE_ALIASES

# Better completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# More comprehensive completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignored-patterns '_*'

# ============================================================================
# 🎉 Startup Experience - Keep the Vibe
# ============================================================================

# ASCII art with random fonts - this is the soul of the terminal
if command -v figlet >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
    # Check which fonts actually exist
    fonts=()
    for font in big banner block doom epic isometric1 larry3d speed; do
        figlet -f $font test >/dev/null 2>&1 && fonts+=($font)
    done
    
    # If we have fonts, use them
    if [[ ${#fonts[@]} -gt 0 ]]; then
        random_font=${fonts[$(($RANDOM % ${#fonts[@]}))]}
        figlet -f $random_font "pab.io" 2>/dev/null | lolcat -a -d 1
    else
        figlet "pab.io" | lolcat -a -d 1
    fi
elif command -v figlet >/dev/null 2>&1; then
    figlet "pab.io"
else
    echo "🎸 pab.io"
fi

echo ""  # Breathing room

# Show a random tip
TIPS=(
    "✨ Type 'extract file.zip' to extract anything"
    "🌤️  Type 'weather' for local forecast"
    "🎸 Type 'projects' to see your active projects"
    "🌙 Claude knows when you should be sleeping"
)
echo "${TIPS[RANDOM % ${#TIPS[@]}]}"
echo ""

# Test different figlet fonts - RESTORED FOR COMMISSIONER!
test-fonts() {
    echo "🎨 Testing figlet fonts for pab.io:"
    echo ""
    echo "1. BIG:"
    figlet -f big "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "2. BANNER:"
    figlet -f banner "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "3. BLOCK:"
    figlet -f block "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "4. DOOM:"
    figlet -f doom "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "5. EPIC:"
    figlet -f epic "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "6. ISOMETRIC1:"
    figlet -f isometric1 "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "7. LARRY3D:"
    figlet -f larry3d "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
    echo "8. SPEED:"
    figlet -f speed "pab.io" 2>/dev/null | lolcat -a -d 1 || figlet "pab.io" | lolcat -a -d 1
    echo ""
}

# System info with style
sysinfo() {
    # Try neofetch first (the pretty one)
    if command -v neofetch >/dev/null 2>&1; then
        neofetch
    # Try fastfetch as alternative (faster)
    elif command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    # Fallback to manual
    else
        echo "🖥️  System Information"
        echo "─────────────────────"
        echo "🍎 macOS: $(sw_vers -productVersion)"
        echo "💻 Shell: $(echo $SHELL)"
        echo "📦 Homebrew: $(brew --version | head -1)"
        echo "🟢 Node: $(node --version 2>/dev/null || echo 'Not loaded (lazy)')"
        echo "🦕 Deno: $(deno --version 2>/dev/null | head -1 || echo 'Not found')"
        echo "🐍 Python: $(python3 --version)"
        echo "💎 Ruby: $(ruby --version | cut -d' ' -f2)"
        echo "📍 Location: Melbourne, AU"
    fi
}

# Quick system stats
alias sys='sysinfo'
alias neofetch='neofetch --ascii_distro mac_small'  # Smaller Apple logo

# Fun colored commands
if command -v lolcat >/dev/null 2>&1; then
    alias rainbow='lolcat'
    fortune() {
        if command -v fortune >/dev/null 2>&1; then
            command fortune | lolcat
        else
            echo "Install fortune: brew install fortune" | lolcat
        fi
    }
fi

# Matrix with color
if command -v cmatrix >/dev/null 2>&1; then
    alias matrix='cmatrix -b -C cyan'
    alias matrix-red='cmatrix -b -C red'
    alias matrix-rainbow='cmatrix -b -C rainbow'
fi

# Clean startup - professional and fast

# ============================================================================
# 🔧 Performance Optimizations
# ============================================================================

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Broot launcher
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# ============================================================================
# 🎁 Final Setup
# ============================================================================

# Ensure all custom directories exist
mkdir -p "$HOME/bin" "$HOME/.local/bin" "$HOME/.config" "$HOME/.npm-global/bin" 2>/dev/null

# Status messages with style
echo "🚀 MCP Terminal loaded! Type 'help' for commands."
echo ""

# Time check
echo "🕐 $(date +'%I:%M %p - %A, %B %d')"

# Fortune for the vibes
if command -v fortune >/dev/null 2>&1 && command -v lolcat >/dev/null 2>&1; then
    echo ""
    fortune | lolcat
elif command -v fortune >/dev/null 2>&1; then
    echo ""
    fortune
fi

echo ""
echo "🎉 Pablo's Epic Terminal Ready! 🚀"
echo "─────────────────────────────────"


# ============================================================================
# Golden Config Manager
alias golden='~/golden/golden.sh'

# Git Monkey Mini - Git learning tool with rainbows 🐒
# REMOVED: source ~/.gitmonkey_mini.zsh  # Simplified - using basic git aliases instead

# ============================================================================
# 🚀 Git Aliases - Moved to main section above (around line 213)
# ============================================================================
# Duplicates removed - check main git section for all aliases

# [Removed duplicate theme-random function]

# Claude Code CLI works via local install - PATH configured below

# ============================================================================
# 🎯 Final Alias Overrides (to ensure clean formatting wins)
# ============================================================================
# Force unalias and re-set clean versions (fighting any conflicting aliases)
unalias ls la ll 2>/dev/null

# EZA_COLORS - Bold Cyberpunk (4 colors only: hot pink, cyan, white, gold)
export EZA_COLORS="di=1;38;5;201:ex=1;38;5;51:ln=1;38;5;201:fi=38;5;15:*.py=38;5;15:*.js=38;5;15:*.json=38;5;15:*.md=38;5;15:*.txt=38;5;15:*.zip=1;38;5;220:*.tar=1;38;5;220:*.png=38;5;15:*.jpg=38;5;15:*.webp=38;5;15:*.mp4=38;5;15:*.mov=38;5;15:*.avi=38;5;15:*.mkv=38;5;15:*.dmg=1;38;5;220:*.docx=1;38;5;220:*.pdf=1;38;5;220:*.doc=1;38;5;220"

alias ls='eza --group-directories-first --sort=type --icons --color=always'   # Organized by type with icons
alias la='eza -a --group-directories-first --classify --color=always --oneline'  # All files, list format  
alias ll='eza -l --group-directories-first --classify --git --color=always --no-permissions --time-style=relative'  # Detailed long format

# ============================================================================
# 🎨 Cyberpunk Command Highlighting
# ============================================================================
# Load zsh-syntax-highlighting for proper command control
if [[ -f ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    
    # Cyberpunk command colors
    ZSH_HIGHLIGHT_STYLES[command]='fg=#00d4ff'           # Commands in electric cyan
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00d4ff'           # Built-ins in electric cyan  
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#00d4ff'             # Aliases in electric cyan
    ZSH_HIGHLIGHT_STYLES[function]='fg=#00d4ff'          # Functions in electric cyan
fi

# End of Pablo's Zsh Config 🎸
export MCP_TIMEOUT=30000

# Claude local installation - FINAL PATH OVERRIDE
export PATH="$HOME/.claude/local/node_modules/.bin:$PATH"
alias icon-gen="node ~/icon-gen.js"

# Keep standard grep working (Oh My Zsh sometimes overrides this)
export SCRAPELESS_KEY="sk_lPNIOCjAYyPdAJ0WeKfjLQzL5DgLQOF8bbANMaMy1lDUQuCKUQbgZB2auJ5fsQxN"
export PUPPETEER_EXECUTABLE_PATH="/Users/pabloalvarado/.cache/puppeteer/chrome/mac_arm-138.0.7204.157/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"

# Claude maintenance
alias claude-clean='python3 ~/.claude/scripts/clean-history.py'
alias claude-size='du -h ~/.claude/config/claude.json'
alias claude-sync='~/.claude/scripts/sync-brain.sh'
alias claude-brain='cd ~/.claude/brain && $EDITOR CLAUDE.md'

# Claude Code permission workarounds (use sparingly)
alias claude-flow='claude --dangerously-skip-permissions'  # Use for uninterrupted sessions
alias claude-trust='claude --allowedTools="Bash(~/.claude/scripts/*),Bash(rolldice *)"'  # Pre-trust common tools
# Notion API key loaded from ~/.env file
[ -f ~/.env ] && source ~/.env

# SoftStack Project Status
alias project-status="~/.claude/scripts/project-status.sh"
alias ps-status="~/.claude/scripts/project-status.sh"  # shorter alias

# System Status Dashboard
alias system-status="~/.claude/scripts/system-status.sh"
alias sys="~/.claude/scripts/system-status.sh"  # shorter alias
