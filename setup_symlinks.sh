#!/bin/bash

# ------------------------------------------------------------------------------
# Dotfiles Setup Script - Enhanced with Backups (Bash v3.2+ Compatible)
# ------------------------------------------------------------------------------
# Script Purpose:
# This script manages user configuration files (dotfiles).
# It performs two primary actions:
#   1. Backs up existing dotfiles from the home directory (~) to a specified
#      backup folder, adding a timestamp to each backup. If the corresponding
#      file is not already in this dotfiles repository, the backed-up version
#      is then copied into this repository. Dotfiles are typically stored in
#      the repository without their leading dot (e.g., '.zshrc' becomes 'zshrc').
#   2. Creates symbolic links in the home directory (e.g., ~/.zshrc), pointing
#      to the files within this dotfiles repository. These links use the
#      original dot-prefixed names.
#
# Usage Instructions:
# 1. Place this script in the root directory of your dotfiles Git repository
#    (e.g., ~/dotfiles/setup_symlinks.sh).
# 2. Navigate to the root of your dotfiles repository in the terminal:
#    cd /path/to/your/dotfiles_repository
# 3. Make the script executable:
#    chmod +x setup_symlinks.sh
# 4. Execute the script:
#    ./setup_symlinks.sh
#
# Important Considerations:
# - BACKUP: It is highly recommended to manually backup original dotfiles
#   from your home directory before the first execution of this script.
# - Idempotency: The script is designed to be run multiple times. It attempts
#   to handle existing files and symlinks appropriately, refreshing links
#   if necessary.
# - Repository Conflicts: If a file already exists in the dotfiles repository
#   (e.g., 'zshrc'), this script will not overwrite it with a version from the
#   home directory. A warning will be issued, and the repository version will
#   be preserved. Manual resolution is required for such conflicts.
#
#                                                            214L@github
# ------------------------------------------------------------------------------

# This script should be run from the root directory of your dotfiles repository.

# --- Configuration ---
# Configurable backup directory path.
# Can be an absolute path (e.g., /my/custom/backups)
# or a relative path (e.g., "backups_here"), which will be inside this repository.
# Default: 'backup' subdirectory within this repository.
BACKUP_DIR_CONFIG="$HOME/Archives/zshrc_backup"
# --- End Configuration ---

# Define files to manage.
# home_file_paths: full paths to the dotfiles in the home directory.
# repo_file_names: corresponding names for these files in the dotfiles repository (without leading dot).
home_file_paths=(
    "$HOME/.zshrc"
    "$HOME/.zshenv"
    "$HOME/.zprofile"
    "$HOME/.bash_profile"
    # Add more full paths to home dotfiles here, e.g.:
    # "$HOME/.gitconfig"
)
repo_file_names=(
    "zshrc"
    "zshenv"
    "zprofile"
    "bash_profile"
    # Add corresponding repo names here, e.g.:
    # "gitconfig"
)

# Set REPO_DIR to the current working directory (script's location).
REPO_DIR="$(pwd)"

# Determine the full backup directory path based on BACKUP_DIR_CONFIG
if [[ "$BACKUP_DIR_CONFIG" == /* ]]; then
  # If BACKUP_DIR_CONFIG starts with '/', it's an absolute path
  FULL_BACKUP_DIR="$BACKUP_DIR_CONFIG"
else
  # Otherwise, it's relative to the REPO_DIR
  FULL_BACKUP_DIR="$REPO_DIR/$BACKUP_DIR_CONFIG"
fi

echo "Dotfiles repository directory set to: $REPO_DIR"
echo "Backups will be stored in: $FULL_BACKUP_DIR"
echo "----------------------------------------"

num_files=${#home_file_paths[@]}
# Check if the arrays have the same number of elements
if [ "$num_files" -ne "${#repo_file_names[@]}" ]; then
    echo "ERROR: Mismatch between the number of home files and repo file names. Please check the arrays."
    exit 1
fi

for (( i=0; i<num_files; i++ )); do
  home_file_path="${home_file_paths[i]}"
  repo_file_name="${repo_file_names[i]}"
  repo_file_path_abs="$REPO_DIR/$repo_file_name" # Absolute path to the target file in the repository.

  echo "Processing: $home_file_path"
  echo "  Target repository file: $repo_file_path_abs"

  # Check if a regular file (not a symlink) exists at the home directory path.
  if [ -f "$home_file_path" ] && [ ! -L "$home_file_path" ]; then
    echo "  Regular file found at $home_file_path."

    # Back up the original file.
    echo "  Backing it up..."
    mkdir -p "$FULL_BACKUP_DIR" # Ensure the backup directory exists.
    original_filename_in_home=$(basename "$home_file_path") # e.g., .zshrc
    timestamp=$(date +%Y%m%d_%H%M%S)
    backup_target_path="$FULL_BACKUP_DIR/${original_filename_in_home}_$timestamp"

    mv "$home_file_path" "$backup_target_path" # Move the original file to the backup directory.
    echo "  Backed up original to $backup_target_path."

    # Original file has been moved from its home location.
    # If the corresponding file is not in the repository, copy the backed-up version to the repository.
    if [ ! -f "$repo_file_path_abs" ]; then
        echo "  File $repo_file_name not found in repository. Copying backed up version to $repo_file_path_abs..."
        cp "$backup_target_path" "$repo_file_path_abs"
        echo "  Copied to repository."
    else
        echo "  File $repo_file_name already exists in repository. Will use that version for the symlink."
    fi

  elif [ -L "$home_file_path" ]; then
    echo "  Found that $home_file_path is already a symbolic link."
    # Existing symlink status noted; will be processed in symlink creation step.
  elif [ ! -e "$home_file_path" ]; then
    echo "  File $home_file_path does not exist in the home directory."
    # If repository file also absent, skip this entry.
    if [ ! -f "$repo_file_path_abs" ]; then
        echo "  And repository file $repo_file_path_abs also does not exist. Cannot process this file."
        echo "----------------------------------------"
        continue # Skip to the next file.
    fi
  fi

  # Proceed with symbolic link creation/verification.
  # The file must exist in the repository to create a symlink.
  if [ -f "$repo_file_path_abs" ]; then
    echo "  Preparing to create/update symbolic link at $home_file_path pointing to $repo_file_path_abs"
    # Remove any existing file or symlink at the target home directory location.
    # This ensures a clean symlink creation.
    if [ -L "$home_file_path" ] || [ -f "$home_file_path" ]; then
        echo "  Deleting existing $home_file_path ..."
        rm -f "$home_file_path" # The -f option forces removal without confirmation.
    fi

    echo "  Creating symbolic link..."
    ln -s "$repo_file_path_abs" "$home_file_path"
    if [ $? -eq 0 ]; then # Check if ln command was successful
        echo "  Symbolic link $home_file_path -> $repo_file_path_abs created successfully."
    else
        echo "  ERROR: Failed to create symbolic link $home_file_path."
    fi
  else
    echo "  ERROR: Repository file $repo_file_path_abs does not exist. Cannot create symbolic link."
  fi
  echo "----------------------------------------"
done

echo "Script execution finished."
echo "Please check the output above for any errors and confirm that symbolic links were created correctly."
echo "You may need to restart your Zsh session (close and reopen your terminal) for all changes to take effect."