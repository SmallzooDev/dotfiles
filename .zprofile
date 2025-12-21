eval "$(/opt/homebrew/bin/brew shellenv)"

iterm2_print_user_vars() {
  CPU=$(uname -m)
  iterm2_set_user_var cpu $CPU
}

CPU=$(uname -m)
if [[ "$CPU" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  export PATH=/opt/homebrew/bin:$PATH
  eval "$(/usr/local/bin/brew shellenv)"
fi

alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias abrew="arch -arm64 /opt/homebrew/bin/brew"

# mise shims - always available to all processes
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Add mysql
export PATH=${PATH}:/usr/local/mysql-8.3.0-macos14-arm64/bin
# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"
