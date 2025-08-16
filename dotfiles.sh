#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/~"

usage() {
    echo "Usage:"
    echo "  $0 add <file>     - Add file to dotfiles repo and create symlink"
    echo "  $0 sync [file]    - Sync symlinks (all files or specific file)"
    echo "  $0                - Sync all symlinks (default)"
    echo ""
    echo "Examples:"
    echo "  $0 add ~/.gitconfig"
    echo "  $0 sync ~/.gitconfig"
    echo "  $0 sync"
    exit 1
}

expand_path() {
    local path="$1"
    # Expand ~ to $HOME
    echo "${path/#\~/$HOME}"
}

get_repo_path() {
    local file_path="$1"
    # Convert absolute path to repo path by replacing $HOME with dotfiles/~
    echo "$DOTFILES_DIR${file_path#$HOME}"
}

add_file() {
    local file_path="$(expand_path "$1")"
    
    if [[ ! -f "$file_path" ]]; then
        echo "Error: File '$file_path' does not exist"
        exit 1
    fi
    
    # Check if it's already a symlink to our repo
    if [[ -L "$file_path" ]]; then
        local link_target="$(readlink "$file_path")"
        if [[ "$link_target" == "$SCRIPT_DIR"* ]]; then
            echo "File '$file_path' is already managed by dotfiles"
            exit 0
        fi
    fi
    
    local repo_path="$(get_repo_path "$file_path")"
    
    # Create directory structure in repo
    mkdir -p "$(dirname "$repo_path")"
    
    # Move file to repo
    echo "Moving '$file_path' to '$repo_path'"
    mv "$file_path" "$repo_path"
    
    # Create symlink
    echo "Creating symlink '$file_path' -> '$repo_path'"
    ln -s "$repo_path" "$file_path"
    
    # Add to git
    cd "$SCRIPT_DIR"
    git add "$repo_path"
    echo "Added '$repo_path' to git staging"
}

sync_file() {
    local file_path="$1"
    local repo_path="$(get_repo_path "$file_path")"
    
    if [[ ! -f "$repo_path" ]]; then
        echo "Error: '$repo_path' not found in dotfiles repo"
        exit 1
    fi
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$file_path")"
    
    # Remove existing file/symlink if it exists
    if [[ -e "$file_path" || -L "$file_path" ]]; then
        echo "Removing existing '$file_path'"
        rm "$file_path"
    fi
    
    # Create symlink
    echo "Creating symlink '$file_path' -> '$repo_path'"
    ln -s "$repo_path" "$file_path"
}

sync_all() {
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        echo "No dotfiles found. Directory '$DOTFILES_DIR' does not exist."
        exit 0
    fi
    
    echo "Syncing all dotfiles..."
    
    # Find all files under dotfiles/~ and create symlinks
    find "$DOTFILES_DIR" -type f | while read -r repo_file; do
        # Convert repo path back to home path
        local home_file="$HOME${repo_file#$DOTFILES_DIR}"
        
        # Create target directory if it doesn't exist
        mkdir -p "$(dirname "$home_file")"
        
        # Remove existing file/symlink if it exists
        if [[ -e "$home_file" || -L "$home_file" ]]; then
            echo "Removing existing '$home_file'"
            rm "$home_file"
        fi
        
        # Create symlink
        echo "Creating symlink '$home_file' -> '$repo_file'"
        ln -s "$repo_file" "$home_file"
    done
    
    echo "All dotfiles synced!"
}

main() {
    case "${1:-sync}" in
        add)
            if [[ -z "$2" ]]; then
                echo "Error: No file specified for add command"
                usage
            fi
            add_file "$2"
            ;;
        sync)
            if [[ -n "$2" ]]; then
                sync_file "$(expand_path "$2")"
            else
                sync_all
            fi
            ;;
        -h|--help)
            usage
            ;;
        *)
            if [[ "$1" == -* ]]; then
                echo "Error: Unknown option '$1'"
                usage
            else
                # Assume it's a file path for backwards compatibility
                echo "Warning: Please use 'add' or 'sync' commands explicitly"
                echo "Assuming you meant: $0 add $1"
                add_file "$1"
            fi
            ;;
    esac
}

main "$@"