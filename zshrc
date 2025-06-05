# ~/.zshrc

# Oh My Zsh Theme (must be set before sourcing Oh My Zsh)
# Ensure spaceship theme is installed:
# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# Oh My Zsh Plugins (must be set before sourcing Oh My Zsh)
# Ensure custom plugins are installed, e.g.:
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
plugins=(
  git
  pyenv
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

# Source Oh My Zsh (ensure $ZSH is defined in ~/.zshenv)
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "WARNING: Oh My Zsh not found at '$ZSH'" >&2
fi

# NVM (Node Version Manager) Initialization
# Ensure NVM_DIR is defined in ~/.zshenv
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # shellcheck source=/dev/null
  \. "$NVM_DIR/nvm.sh"  # This loads nvm
  if [ -s "$NVM_DIR/bash_completion" ]; then
    # shellcheck source=/dev/null
    \. "$NVM_DIR/bash_completion"
  fi
else
  echo "WARNING: NVM script not found at '$NVM_DIR/nvm.sh'" >&2
fi

# Pyenv shell integration (for completions, prompt, etc.)
# The Oh My Zsh 'pyenv' plugin usually handles this.
# If you want to be explicit or if the plugin doesn't cover it fully:
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# -------------------------------- #
# Node Package Manager Aliases (using 'nr' from 'ni')
# -------------------------------- #
# https://github.com/antfu/ni
alias ns="nr start"
alias nd="nr dev"
alias nb="nr build"
alias nbw="nr build --watch"
alias nt="nr test"
alias ntu="nr test -u"
alias ntw="nr test --watch"
alias nw="nr watch"
alias np="nr play"
alias nc="nr typecheck"
alias nre="nr release"

# -------------------------------- #
# Custom Directory Functions
# -------------------------------- #
function p() { 
  cd "$HOME/Project/$1"
}

function mkcd() {
  mkdir "$1" && cd "$1"
}

# Clone to ~/Project/ (implicitly via pd) and cd to it, then open in VS Code
function clonep() {
  if [ -n "$1" ]; then
    local project_dir_arg="$1"
    shift 
    p "$project_dir_arg" && clone "$@" && code . && cd ~2
  else
    echo "clonep: missing project directory argument for 'pd' and/or clone arguments" >&2
  fi
}

function codep() {
  if [ -n "$1" ]; then
    local project_dir_arg="$1"
    shift
    p "$project_dir_arg" && code "$@" && cd -
  else
    echo "codep: missing project directory argument for 'pd'" >&2
  fi
}