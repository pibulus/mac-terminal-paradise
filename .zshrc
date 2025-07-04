#!/bin/zsh
# ============================================================================
# 🎯 Pablo's Ultimate Zsh Configuration - EPIC + TERMINAL POWER CLEANED
# ============================================================================

# Path configuration (secure and optimized)
export PATH="$HOME/.deno/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Add Homebrew to PATH (Apple Silicon and Intel)
if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
elif [[ -d "/usr/local/bin" ]]; then
    export PATH="/usr/local/bin:$PATH"
fi

# Add Python user base bin to PATH (secure detection)
if command -v python3 >/dev/null 2>&1; then
    PYTHON_USER_BASE=$(python3 -m site --user-base 2>/dev/null)
    if [[ -n "$PYTHON_USER_BASE" && -d "$PYTHON_USER_BASE/bin" ]]; then
        export PATH="$PYTHON_USER_BASE/bin:$PATH"
    fi
fi

# ============================================================================
# 🛠️ Development Tools
# ============================================================================

# Homebrew (for Apple Silicon Macs)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# NVM (Node Version Manager) - CRITICAL for Claude Code
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

# Homebrew command-not-found
[[ -f "$(brew --prefix)/etc/profile.d/command-not-found.zsh" ]] && source "$(brew --prefix)/etc/profile.d/command-not-found.zsh"

# ============================================================================
# 🚀 Initialize External Tools
# ============================================================================

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Zoxide - smarter cd (replaces z plugin)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# The Fuck - fix command typos
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# Direnv - per-project environments
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# Better LS colors
command -v vivid >/dev/null 2>&1 && export LS_COLORS="$(vivid generate molokai)"

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

# Better ls with eza (fallback to regular ls)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias l='eza --icons --group-directories-first'
    alias ll='eza -la --icons --group-directories-first --git'
    alias la='eza -la --icons --group-directories-first'
    alias lt='eza --tree --icons --level=2'
    alias tree='eza --tree --icons'
else
    alias ll='ls -la'
    alias la='ls -la'
fi

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Use trash if available, otherwise use rm -i
command -v trash >/dev/null 2>&1 && alias rm='trash' || alias rm='rm -i'

# Modern replacements (only if installed)
command -v bat >/dev/null 2>&1 && alias cat='bat' && export BAT_THEME="Dracula"
command -v btop >/dev/null 2>&1 && alias top='btop' && alias htop='btop'
command -v duf >/dev/null 2>&1 && alias df='duf'
command -v dust >/dev/null 2>&1 && alias du='dust'
command -v procs >/dev/null 2>&1 && alias ps='procs'
command -v rg >/dev/null 2>&1 && alias grep='rg'
command -v fd >/dev/null 2>&1 && alias find='fd'
command -v gping >/dev/null 2>&1 && alias ping='gping'
command -v dog >/dev/null 2>&1 && alias dig='dog'

# Git shortcuts (with safety improvements)
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'

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

# Deno shortcuts
alias deno-version='deno --version'
alias dr='deno run'
alias dt='deno test' 
alias df='deno fmt'

# Fresh shortcuts
alias fresh='deno run -A --watch=static/,routes/ dev.ts'

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

# Quick git init
ginit() {
    git init
    echo "# ${PWD##*/}" > README.md
    echo ".DS_Store" > .gitignore
    echo "*.log" >> .gitignore
    echo "node_modules/" >> .gitignore
    echo ".env" >> .gitignore
    git add .
    git commit -m "Initial commit"
    echo "✅ Git repository initialized"
}

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

# ============================================================================
# 🚀 TERMINAL POWER INTEGRATION (Conditional - Only if installed)
# ============================================================================

# Check if Terminal Power is installed and load conditionally
if [[ -d "$HOME/Terminal_Power" ]] || [[ -f "$HOME/voice-to-claude.sh" ]]; then
    # Terminal Power is installed - load full integration
    
    # Voice & AI shortcuts
    [[ -f "$HOME/voice-to-claude.sh" ]] && alias voice='~/voice-to-claude.sh'
    [[ -f "$HOME/voice-to-claude.sh" ]] && alias voice5='~/voice-to-claude.sh 5'
    [[ -f "$HOME/voice-to-claude.sh" ]] && alias voice10='~/voice-to-claude.sh 10'
    [[ -f "$HOME/github-search.sh" ]] && alias ghsearch='~/github-search.sh'
    [[ -f "$HOME/github-search.sh" ]] && alias findcode='~/github-search.sh'
    [[ -f "$HOME/porkbun-search.sh" ]] && alias domains='~/porkbun-search.sh'
    [[ -f "$HOME/porkbun-search.sh" ]] && alias domainprice='~/porkbun-search.sh pricing'

    # Terminal Power Creative Pack (work immediately - no API keys needed)
    [[ -f "$HOME/weather-tools.sh" ]] && alias weather='~/weather-tools.sh'
    alias qr='function _qr() { curl -s "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$1" -o qr.png && echo "QR code saved as qr.png"; }; _qr'
    [[ -f "$HOME/color-tools.sh" ]] && alias colorname='~/color-tools.sh name'
    [[ -f "$HOME/color-tools.sh" ]] && alias colorscheme='~/color-tools.sh scheme'
    [[ -f "$HOME/color-tools.sh" ]] && alias palette='~/color-tools.sh palette'
    alias quote='curl -s "https://dummyjson.com/quotes/random" | jq -r ".quote + \" - \" + .author"'
    alias fake='function _fake() { curl -s "https://fakerapi.it/api/v1/${1:-persons}?_quantity=${2:-3}" | jq .; }; _fake'
    alias shorten='function _shorten() { curl -s "https://is.gd/create.php?format=simple&url=$1"; }; _shorten'
    alias placeholder='function _placeholder() { echo "https://dummyimage.com/${1:-800}x${2:-600}"; }; _placeholder'
    alias uuid='curl -s "https://httpbin.org/uuid" | jq -r ".uuid"'
    alias myip='curl -s "https://httpbin.org/ip" | jq -r ".origin"'
    alias catfact='curl -s "https://catfact.ninja/fact" | jq -r ".fact"'
    alias joke='curl -s "https://official-joke-api.appspot.com/random_joke" | jq -r ".setup + \" \" + .punchline"'

    # Voice & TTS (works with system TTS immediately)
    [[ -f "$HOME/voice-response.sh" ]] && alias speak='~/voice-response.sh'
    [[ -f "$HOME/voice-response.sh" ]] && alias voice-config='~/voice-response.sh config'

    # Photo APIs (needs free Unsplash key for full power)
    alias photo='function _photo() { if [[ -n "$UNSPLASH_ACCESS_KEY" ]]; then curl -s "https://api.unsplash.com/photos/random?query=$1" -H "Authorization: Client-ID $UNSPLASH_ACCESS_KEY" | jq -r ".urls.regular"; else echo "Get free Unsplash key: https://unsplash.com/developers - 50 photos/hour free!"; fi; }; _photo'

    # MCP Help System - Interactive AI Terminal Control
    [[ -f "$HOME/bin/mcphelp" ]] && alias mcphelp='~/bin/mcphelp'
    [[ -f "$HOME/bin/mcphelp" ]] && alias mcp='~/bin/mcphelp'
    [[ -f "$HOME/bin/mcphelp" ]] && alias mcpapi='~/bin/mcphelp api'
    [[ -f "$HOME/bin/mcphelp" ]] && alias mcptest='~/bin/mcphelp test'

    # Cheat system (Terminal Power specific)
    [[ -f "$HOME/bin/cheat" ]] && alias help='cheat' || alias help='echo "🚀 Terminal Power commands: voice, weather, qr, colorname, quote, fake, uuid, myip"'
    [[ -f "$HOME/bin/cheat" ]] && alias '?'='cheat' || alias '?'='help'

    # Load Terminal Power environment (only if local env file exists)
    [[ -f "$HOME/.terminal-power-env" ]] && source "$HOME/.terminal-power-env"
    
    echo "🚀 Terminal Power loaded! Type 'help' for commands."
else
    # Terminal Power not installed - provide helpful fallbacks
    alias help='echo "💡 Epic terminal setup active! Install Terminal Power for voice commands: https://github.com/user/Terminal_Power"'
    alias '?'='help'
    
    # Basic versions of useful commands that don\'t require Terminal Power
    alias qr='function _qr() { curl -s "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=$1" -o qr.png && echo "QR code saved as qr.png"; }; _qr'
    alias quote='curl -s "https://dummyjson.com/quotes/random" | jq -r ".quote + \" - \" + .author"'
    alias uuid='curl -s "https://httpbin.org/uuid" | jq -r ".uuid"'
    alias myip='curl -s "https://httpbin.org/ip" | jq -r ".origin"'
    alias catfact='curl -s "https://catfact.ninja/fact" | jq -r ".fact"'
    alias joke='curl -s "https://official-joke-api.appspot.com/random_joke" | jq -r ".setup + \" \" + .punchline"'
fi

# ============================================================================
# 🚀 CLAUDE CODE MEMORY PROTECTION (Always Available)
# ============================================================================

# Claude Code memory protection aliases (independent of Terminal Power)
alias claude-safe='NODE_OPTIONS="--max-old-space-size=8192" claude'
alias claude-fresh='pkill -f claude 2>/dev/null; NODE_OPTIONS="--max-old-space-size=8192" claude'

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

# Key bindings for productivity
bindkey -e  # Emacs-style bindings

# History search with arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Shell options for better experience
setopt AUTO_CD              # Just type directory name to cd
setopt AUTO_PUSHD          # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS   # No duplicates in stack

# Better completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# ============================================================================
# 🎉 Epic Startup Experience
# ============================================================================

# Test Deno on load
if command -v deno >/dev/null 2>&1; then
    echo "✅ Deno $(deno --version | head -1) ready!"
else
    echo "❌ Deno not found in PATH"
fi

# Random tips on startup
TIPS=(
    "💡 Use 'z' to jump to any directory you've visited"
    "🚀 Press Ctrl+R for fuzzy history search"
    "📁 Press Ctrl+T to find files with fzf"
    "📂 Press Alt+C to cd with fzf"
    "🔥 Press Ctrl+G for interactive git status"
    "📝 Press Ctrl+F to find and edit files"
    "⚡ Double-tap ESC to add 'sudo' to command"
    "🎯 Type 'help' for your cheatsheet menu"
    "✨ Type 'extract file.zip' to extract anything"
    "🚀 Type 'ginit' to quickly start a git repo"
    "💾 Type 'backup file' to backup with timestamp"
    "🌤️  Type 'weather' for local forecast"
    "📝 Type 'note' to add a quick note"
    "🦕 Type 'dinit' to create a new Deno project"
    "🤖 Type 'claude-safe' for memory-protected Claude Code"
    "🎙️ Type 'voice' for AI voice commands"
    "🎨 Type 'colorname FF69B4' to identify colors"
    "📦 Type 'qr \"Hello World\"' to make QR codes"
)

# Show random tip
echo "${TIPS[RANDOM % ${#TIPS[@]}]}"
echo ""

# ============================================================================
# 🚀 Performance Optimizations
# ============================================================================

# Lazy load NVM to speed up shell startup (EPIC FEATURE!)
lazy_load_nvm() {
    unset -f node npm npx nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }
nvm() { lazy_load_nvm; nvm "$@"; }

# Ripgrep configuration
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Broot launcher
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br