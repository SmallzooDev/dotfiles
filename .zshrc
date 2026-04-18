# Minimal zshrc without oh-my-zsh
# This is a faster alternative configuration

# Basic environment
export EDITOR=nvim

setopt SHARE_HISTORY

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

alias cdp='cd ~/public_vault'
alias cds='cd ~/private_vault'
alias cdd='cd ~/dotfiles'

# Editor
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
alias vi='nvim'
alias n='nvim .'
alias vip='cd ~/public_vault && nvim home.md'
alias vis='cd ~/private_vault && nvim home.md'
alias vid='cd ~/dotfiles && nvim .'
alias ch='vi ~/public_vault/cheatsheet.md'

# Scripts
alias ii='./init.sh'
alias rr='./run.sh'
alias ss='./submit.sh'

# Racket
alias rkt='racket -l sicp -i'

# LLM alias
alias cl='claude'
alias gem='gemini'
alias cdx='codex'

# tmux: default to session 17
alias t='tmux new-session -A -s 17'

# Other aliases
alias killp='kill -9'
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias ports='lsof -i -P'


source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
bindkey '^G' fzf-home-widget

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git --exclude .obsidian --exclude .idea"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude .obsidian --exclude .idea"

# Rose Pine Moon theme for FZF
export FZF_DEFAULT_OPTS="--color=bg+:#393552,bg:#232136,spinner:#c4a7e7,hl:#eb6f92 --color=fg:#e0def4,header:#eb6f92,info:#3e8fb0,pointer:#9ccfd8 --color=marker:#ea9a97,fg+:#e0def4,prompt:#c4a7e7,hl+:#eb6f92 --color=selected-bg:#44415a"

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
export PATH="$HOME/.local/bin:$PATH"
