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
alias h='herdr'

# Other aliases
alias killp='kill -9'
alias ll='ls -alF'
alias ..='cd ..'
alias ...='cd ../..'
alias ports='lsof -i -P'


source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
zstyle ':completion:*' list-colors 'ma=0;7' 'di=34' 'ln=36' 'ex=32'
zstyle ':completion:*:descriptions' format '%F{8}%d%f'
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

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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
export GOBIN=$GOPATH/bin
export PATH="$HOME/.local/bin:$PATH"

# colorscheme theme switcher (`theme coolnight|github-dark`)
export PATH="$HOME/dotfiles/colorscheme/bin:$PATH"

gos() {
	if [[ $# -ne 1 ]]; then
		echo "usage: gos <name>[.go]" >&2
		return 1
	fi
	local file="${1%.go}.go"
	if [[ -e $file ]]; then
		echo "gos: $file already exists" >&2
		return 1
	fi
	cat > "$file" <<'EOF'
//go:build ignore

package main

import "fmt"

func main() {
	fmt.Println("hello")
}
EOF
	"${EDITOR:-nvim}" "$file"
}

# db study (postgres client)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
