# Minimal zshrc without oh-my-zsh
# This is a faster alternative configuration

# Basic environment
export EDITOR=hx

# Git aliases (replacing oh-my-zsh git plugin)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

# Your custom aliases
alias gtwk='cd ~/wiki/SmallzooDevWiki/content/_wiki'
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
alias vi='hx'
alias h='hx .'

# Scripts
alias ii='./init.sh'

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
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


# FZF
eval "$(fzf --zsh)"

# FZF configuration
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# FZF functions
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh



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
set -o vi
