# Minimal zshrc without oh-my-zsh
# This is a faster alternative configuration

# Basic environment
export EDITOR=hx

# Development utilities
source ~/dev-utils/shell/devenv.zsh

# Git aliases (replacing oh-my-zsh git plugin)
alias lg='lazygit'

# custom aliases
alias gtwk='cd ~/wiki/SmallzooDevWiki/content/_wiki'
alias gtdf='cd ~/dotfiles'
alias gtnv='cd ~/.config/nvim'
alias gtrs='cd ~/dev/coding_interview_rust'
alias gtkt='cd ~/dev/CodingInterviewKotlin'
alias book='cd ~/Books && open .'

# Move
alias gd=pushd
alias pd=popd

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Editor
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
alias vi='nvim'
alias n='nvim .'
alias vip='cd ~/public_vault && nvim home.md'
alias vis='cd ~/private_vault && nvim home.md'

# Scripts
alias ii='./init.sh'
alias rr='./run.sh'
alias ss='./submit.sh'

# LLM Agents
alias cl='claude'
alias gem='gemini'

# Other aliases
alias killp='kill -9'
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias ports='lsof -i -P'

# Load plugins directly (much faster than oh-my-zsh)
# These are installed via oh-my-zsh, so we use those paths

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set vi mode before fzf to avoid keybinding conflicts
set -o vi

# FZF
eval "$(fzf --zsh)"

# Change ALT+C to CTRL+F for directory navigation
bindkey '^F' fzf-cd-widget

# CTRL+H: fzf directory navigation starting from home
fzf-home-widget() {
  local dir
  dir=$(fd --type=d --hidden --exclude .git --exclude .obsidian --exclude .idea . ~ | fzf +m) && cd "$dir"
  zle reset-prompt
}
zle -N fzf-home-widget
bindkey '^H' fzf-home-widget

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude .obsidian --exclude .idea"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude .obsidian --exclude .idea"

# Catppuccin Mocha theme for FZF
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --multi"

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# FZF functions
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


# Yazi function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Initialize Starship prompt
eval "$(starship init zsh)"

# mise version manager
eval "$(mise activate zsh)"
