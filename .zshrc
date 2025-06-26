#!/bin/zsh
# Pablo's Minimal Zsh Configuration

# PATH setup - Deno FIRST to ensure it works
export PATH="$HOME/.deno/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Homebrew
if [[ -d "/opt/homebrew/bin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Editor
export EDITOR='micro'
export VISUAL='micro'

# Oh My Zsh (minimal setup)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # We'll use Starship
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# External tools (only if available)
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v thefuck >/dev/null 2>&1 && eval "$(thefuck --alias)"

# FZF configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
command -v bat >/dev/null 2>&1 && export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --color=always --line-range :500 {}'"
command -v fd >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

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

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Basic aliases
alias ll='ls -la'
alias la='ls -la'
alias reload='source ~/.zshrc'

# File operations with safety
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Modern CLI replacements (only if available)
command -v bat >/dev/null 2>&1 && alias cat='bat' && export BAT_THEME="Dracula"
command -v eza >/dev/null 2>&1 && alias ls='eza --icons --group-directories-first' && alias ll='eza -la --icons --group-directories-first' && alias tree='eza --tree --icons'
command -v btop >/dev/null 2>&1 && alias top='btop'
command -v duf >/dev/null 2>&1 && alias df='duf'
command -v dust >/dev/null 2>&1 && alias du='dust'
command -v rg >/dev/null 2>&1 && alias grep='rg'
command -v fd >/dev/null 2>&1 && alias find='fd'

# History improvements
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

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

weather() {
    local location="${1:-Melbourne}"
    curl -s "wttr.in/${location}?format=v2" 2>/dev/null || echo "Weather service unavailable"
}

# Git shortcuts with basic safety
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

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

# Development shortcuts
alias serve='python3 -m http.server 8000'
alias myip='curl -s ipinfo.io | jq 2>/dev/null || curl -s ipinfo.io'
alias localip='ipconfig getifaddr en0 2>/dev/null || echo "No network connection"'
alias ports='lsof -PiTCP -sTCP:LISTEN'

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

# Cheat system
alias help='cheat'
alias '?'='cheat'

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

# Random tips on startup
TIPS=(
    "💡 Use 'z' to jump to any directory you've visited"
    "🚀 Press Ctrl+R for fuzzy history search"
    "📁 Press Ctrl+T to find files with fzf"
    "🎯 Type 'help' for your cheatsheet menu"
    "✨ Type 'extract file.zip' to extract anything"
    "🚀 Type 'ginit' to quickly start a git repo"
    "💾 Type 'backup file' to backup with timestamp"
    "🌤️  Type 'weather' for local forecast"
    "📝 Type 'note' to add a quick note"
    "🦕 Type 'dinit' to create a new Deno project"
)

# Show random tip
echo "${TIPS[RANDOM % ${#TIPS[@]}]}"
echo ""

# Test Deno on load
if command -v deno >/dev/null 2>&1; then
    echo "✅ Deno $(deno --version | head -1) ready!"
else
    echo "❌ Deno not found in PATH"
    echo "PATH: $PATH"
fi