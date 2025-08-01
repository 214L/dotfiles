# Dotfiles

A minimal dotfiles repository for managing shell configurations across multiple environments.

## Features

- **Multi-shell support**: Zsh and Bash configurations
- **Development tools**: NVM, Pyenv, Oh My Zsh integration
- **Node.js aliases**: Convenient commands using `ni` package manager
- **Project management**: VS Code integration and directory shortcuts
- **Secure environment variables**: Local config management with git exclusion

## Quick Start

### Prerequisites

Install required dependencies:

```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Spaceship theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
```

### Installation

```bash
chmod +x setup_symlinks.sh
./setup_symlinks.sh
exec zsh
```

## Configuration

### Shell Configurations

- **zshrc**: Main Zsh configuration with Oh My Zsh, plugins, and aliases
- **zshenv**: Environment variables for Zsh
- **zprofile**: System-level configurations (Homebrew, Pyenv)
- **bash_profile**: Bash environment setup

### Node.js Development Aliases

```bash
ns="nr start"      # Start project
nd="nr dev"        # Development mode
nb="nr build"      # Build project
nt="nr test"       # Run tests
nc="nr typecheck"  # Type checking
```

### Project Management Functions

```bash
p <project>        # Navigate to Projects directory
mkcd <dir>         # Create directory and enter
clonep <project>   # Clone to Projects and open in VS Code
codep <project>    # Open project in VS Code
```

### Environment Variables

For sensitive data (API keys, etc.):

1. Edit the `env` file in the repository
2. Add your variables:
   ```bash
   export ANTHROPIC_AUTH_TOKEN="your-token"
   export ANTHROPIC_BASE_URL="your-url"
   ```
3. Run `./setup_symlinks.sh`

**Note**: The `env` file is excluded from git tracking.

## Project Structure

```
dotfiles/
├── README.md              # Documentation
├── setup_symlinks.sh     # Deployment script
├── zshrc                 # Main Zsh config
├── zshenv                # Zsh environment
├── zprofile              # System config
├── bash_profile          # Bash config
└── env                   # Local environment (git-ignored)
```

## Customization

### Adding New Config Files

1. Add to `setup_symlinks.sh`:
   ```bash
   home_file_paths=(
       "$HOME/.your_file"
   )
   repo_file_names=(
       "your_file"
   )
   ```
2. Create the file and run `./setup_symlinks.sh`

### Adding Aliases

Edit `zshrc` and add:
```bash
alias your_alias="your_command"
```

## License

MIT License - see [LICENSE](LICENSE) for details.