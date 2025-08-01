# ~/.zshenv

# Oh My Zsh Path
export ZSH="$HOME/.oh-my-zsh"

# NVM 
export NVM_DIR="$HOME/.nvm"

# Pyenv 
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Local environment variables (contain sensitive data)
# Load from symlinked file in dotfiles repository
if [ -f "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi
