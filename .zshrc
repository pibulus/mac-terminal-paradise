#!/bin/zsh
# ============================================================================
# 🎯 Pablo's Ultimate Zsh Configuration - ENHANCED VERSION
# ============================================================================

# Path configuration (updated for modern Python)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:$HOME/Library/Python/3.*/bin:$PATH"
[[ $(uname -m) == "arm64" ]] && PATH="/opt/homebrew/bin:$PATH"
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
# 🛠️ Development Tools
# ============================================================================

# Homebrew (for Apple Silicon Macs)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# NVM (Node Version Manager)
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

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'
alias gdiff='git diff --color-words'

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

# Network
alias myip='curl -s ipinfo.io | jq'
alias localip='ipconfig getifaddr en0'
command -v speedtest-cli >/dev/null 2>&1 && alias speedtest='speedtest-cli'
alias ports='lsof -PiTCP -sTCP:LISTEN'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

# Fun stuff (only if installed)
command -v cmatrix >/dev/null 2>&1 && alias matrix='cmatrix -b'
command -v tty-clock >/dev/null 2>&1 && alias clock='tty-clock -c -C 4'
command -v asciiquarium >/dev/null 2>&1 && alias aquarium='asciiquarium'
command -v sl >/dev/null 2>&1 && alias trains='sl'
alias weather='curl -s wttr.in'
alias moon='curl -s wttr.in/Moon'
alias bitcoin='curl -s rate.sx/btc'
alias parrot='curl parrot.live'

# Task Master
alias tm='task-master'
alias taskmaster='task-master'

# Pablo's Cheatsheet System
alias help='cheat'
alias h='cheat'
alias '?'='cheat'
alias /cheat='cheat'
alias /help='cheat'
alias menu='cheat'
alias helptext='glow ~/terminal-cheatsheet.md'
alias cheatsheet='bat ~/terminal-cheatsheet.md'

# ============================================================================
# ⌨️ Keybindings - The Missing Productivity Boost!
# ============================================================================

# Enable vi mode but keep emacs bindings for ctrl
bindkey -e

# History search with arrow keys (NOW WITH THE RIGHT PLUGIN!)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# FZF powered keybindings
# Ctrl+T - Find files
# Ctrl+R - Search history (already set by fzf)
# Alt+C - cd into directories

# Custom FZF functions bound to keys
# Ctrl+G - Interactive git status
fzf-git-status() {
    local selected=$(git status -s | fzf --preview 'git diff --color {2}' | awk '{print $2}')
    LBUFFER="${LBUFFER}${selected}"
    zle reset-prompt
}
zle -N fzf-git-status
bindkey '^G' fzf-git-status

# Ctrl+F - Find and edit files
fzf-find-edit() {
    local file=$(fzf --preview 'bat --color=always {}')
    if [[ -n $file ]]; then
        ${EDITOR} "$file"
    fi
}
zle -N fzf-find-edit
bindkey '^F' fzf-find-edit

# Alt+D - cd to recent directories with zoxide
bindkey -s '^[d' 'zi\n'

# Ctrl+P - Search running processes
fzf-kill-process() {
    local pid=$(ps aux | sed 1d | fzf -m | awk '{print $2}')
    if [[ -n $pid ]]; then
        echo $pid | xargs kill -9
    fi
}
zle -N fzf-kill-process
bindkey '^P' fzf-kill-process

# ============================================================================
# 🔧 Functions
# ============================================================================

# Make directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Create a tar.gz archive
targz() {
    if [ $# -eq 0 ]; then
        echo "Usage: targz <files/directories>"
        return 1
    fi
    tar -czf "${1%/}.tar.gz" "$@"
    echo "Created ${1%/}.tar.gz"
}

# Quick git init with initial commit
ginit() {
    git init
    echo "# ${PWD##*/}" > README.md
    echo ".DS_Store" > .gitignore
    echo "*.log" >> .gitignore
    echo "node_modules/" >> .gitignore
    echo ".env" >> .gitignore
    echo "*.swp" >> .gitignore
    git add .
    git commit -m "Initial commit"
    echo "✅ Git repository initialized with README and .gitignore"
}

# Backup file with timestamp
backup() {
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
    echo "✅ Backed up to: $1.bak.$(date +%Y%m%d_%H%M%S)"
}

# Weather function
weather() {
    curl -s "wttr.in/${1:-Melbourne}?format=v2"
}

# Cheatsheet for any command
cht() {
    curl -s "cheat.sh/$1" | bat --style=plain
}

# Quick notes
note() {
    echo "$(date +'%Y-%m-%d %H:%M:%S'): $*" >> ~/notes.txt
    echo "✅ Note saved!"
}

# Show all notes
notes() {
    if [ -f ~/notes.txt ]; then
        bat ~/notes.txt 2>/dev/null || cat ~/notes.txt
    else
        echo "No notes yet. Use 'note' to add one!"
    fi
}

# Search shortcuts for cheatsheet
hlp() {
    if [ -f ~/terminal-cheatsheet.md ]; then
        grep -i "${1:-}" ~/terminal-cheatsheet.md --color=always | bat --style=plain
    else
        echo "Cheatsheet not found. Create ~/terminal-cheatsheet.md first!"
    fi
}

# Quick benchmark any command
bench() {
    if [ $# -eq 0 ]; then
        echo "Usage: bench <command>"
        return 1
    fi
    for i in {1..10}; do time "$@" &> /dev/null; done
}

# Extract any archive
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

# ============================================================================
# 🎯 Shell Options & Completion
# ============================================================================

# Enable better tab completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# History improvements
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY

# Better directory navigation
setopt AUTO_CD              # Just type directory name to cd
setopt AUTO_PUSHD          # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS   # No duplicates in stack
setopt PUSHD_MINUS         # Exchange + and -
setopt CDABLE_VARS         # cd to variable values

# ============================================================================
# 🔐 Secrets & Local Config
# ============================================================================

# Load secrets from separate file
[ -f ~/.secrets ] && source ~/.secrets

# Load local machine-specific config
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ============================================================================
# 🎊 Welcome Message
# ============================================================================

# Show a random tip when terminal starts
if command -v shuf >/dev/null 2>&1 || command -v gshuf >/dev/null 2>&1; then
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
        "📦 Type 'targz files' to create archives"
        "💾 Type 'backup file' to backup with timestamp"
        "🌤️  Type 'weather' for local forecast"
        "📝 Type 'note' to add a quick note"
        "🔍 Press Ctrl+P to search & kill processes"
        "🎨 Press Cmd+` to summon Ghostty anywhere!"
    )
    
    # macOS doesn't have shuf, but has gshuf from coreutils
    if command -v shuf >/dev/null 2>&1; then
        echo "${TIPS[$(shuf -i 0-$((${#TIPS[@]}-1)) -n 1)]}"
    else
        echo "${TIPS[RANDOM % ${#TIPS[@]}]}"
    fi
    echo ""
fi

# Broot launcher
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

# ============================================================================
# 🚀 Performance Optimizations
# ============================================================================

# Lazy load NVM to speed up shell startup
lazy_load_nvm() {
    unset -f node npm npx nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

node() { lazy_load_nvm; node "$@"; }
npm() { lazy_load_nvm; npm "$@"; }
npx() { lazy_load_nvm; npx "$@"; }
nvm() { lazy_load_nvm; nvm "$@"; }export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
