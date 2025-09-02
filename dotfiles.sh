#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/~"
DIRS_MANIFEST="$SCRIPT_DIR/.dirlinks"

usage() {
    echo "Usage:"
    echo "  $0 add <path>       - Add file/dir (per-file for dirs)"
    echo "  $0 add-dir <dir>    - Add directory as a single symlink"
    echo "  $0 sync [path]      - Sync symlinks (all, file, or directory)"
    echo "  $0 sync-dir <dir>   - Sync directory symlink"
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

to_tilde_path() {
    local abs="$1"
    echo "${abs/#$HOME/~}"
}

# Remove trailing slash from a path (except root '/')
strip_trailing_slash() {
    local p="$1"
    if [[ "$p" == "/" ]]; then
        echo "/"
    else
        # Remove one trailing slash if present
        echo "${p%/}"
    fi
}

ensure_manifest() {
    if [[ ! -f "$DIRS_MANIFEST" ]]; then
        : > "$DIRS_MANIFEST"
    fi
}

is_dir_tracked() {
    local abs="$(strip_trailing_slash "$1")"
    local t="$(to_tilde_path "$abs")"
    [[ -f "$DIRS_MANIFEST" ]] && grep -Fxq "$t" "$DIRS_MANIFEST"
}

add_single_file() {
    local file_path="$1"

    # Check if it's already a symlink to our repo
    if [[ -L "$file_path" ]]; then
        local link_target="$(readlink "$file_path")"
        if [[ "$link_target" == "$SCRIPT_DIR"* ]]; then
            echo "File '$file_path' is already managed by dotfiles"
            return 0
        fi
    fi

    local repo_path="$(get_repo_path "$file_path")"

    # Create directory structure in repo
    mkdir -p "$(dirname "$repo_path")"

    # Move file to repo
    echo "Moving '$file_path' to '$repo_path'"
    if ! mv "$file_path" "$repo_path"; then
        echo "Error: Failed to move file to repo"
        exit 1
    fi

    # Create symlink (with rollback if it fails)
    echo "Creating symlink '$file_path' -> '$repo_path'"
    if ! ln -s "$repo_path" "$file_path"; then
        echo "Link creation failed, rolling back move"
        mv "$repo_path" "$file_path"
        exit 1
    fi

    # Add to git
    cd "$SCRIPT_DIR"
    git add "$repo_path"
    echo "Added '$repo_path' to git staging"
}

add_file() {
    local path="$(expand_path "$1")"

    if [[ -f "$path" ]]; then
        add_single_file "$path"
    elif [[ -d "$path" ]]; then
        # Walk all regular files under the directory (per-file behavior)
        find "$path" -type f -print0 | while IFS= read -r -d '' f; do
            add_single_file "$f"
        done
    else
        echo "Error: Path '$path' does not exist or is not a regular file/directory"
        exit 1
    fi
}

add_dir() {
    local dir_path="$(strip_trailing_slash "$(expand_path "$1")")"
    if [[ ! -d "$dir_path" ]]; then
        echo "Error: Directory '$dir_path' does not exist"
        exit 1
    fi

    # If it's already a symlink pointing into our repo, skip
    if [[ -L "$dir_path" ]]; then
        local link_target="$(readlink "$dir_path")"
        if [[ "$link_target" == "$SCRIPT_DIR"* ]]; then
            echo "Directory '$dir_path' is already managed by dotfiles"
            return 0
        fi
    fi

    local repo_dir="$(strip_trailing_slash "$(get_repo_path "$dir_path")")"
    mkdir -p "$(dirname "$repo_dir")"

    echo "Moving directory '$dir_path' to '$repo_dir'"
    if ! mv "$dir_path" "$repo_dir"; then
        echo "Error: Failed to move directory to repo"
        exit 1
    fi

    echo "Creating directory symlink '$dir_path' -> '$repo_dir'"
    if ! ln -s "$repo_dir" "$dir_path"; then
        echo "Link creation failed, rolling back move"
        mv "$repo_dir" "$dir_path"
        exit 1
    fi

    # Track this directory symlink in manifest
    ensure_manifest
    local t="$(to_tilde_path "$dir_path")"
    if ! grep -Fxq "$t" "$DIRS_MANIFEST"; then
        echo "$t" >> "$DIRS_MANIFEST"
    fi

    # Add to git
    cd "$SCRIPT_DIR"
    git add "$repo_dir" "$DIRS_MANIFEST"
    echo "Added '$repo_dir' and updated directory manifest"
}

sync_single_file() {
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

sync_file() {
    local path="$1"
    if [[ -f "$path" || ( -L "$path" && ! -d "$path" ) ]]; then
        sync_single_file "$path"
    elif [[ -d "$path" ]]; then
        if is_dir_tracked "$path"; then
            sync_dir "$path"
        else
            local repo_dir="$(get_repo_path "$path")"
            if [[ ! -d "$repo_dir" ]]; then
                echo "Error: '$repo_dir' not found in dotfiles repo"
                exit 1
            fi
            # Walk all files tracked in repo under this directory
            find "$repo_dir" -type f -print0 | while IFS= read -r -d '' repo_file; do
                local home_file="$HOME${repo_file#$DOTFILES_DIR}"
                mkdir -p "$(dirname "$home_file")"
                if [[ -e "$home_file" || -L "$home_file" ]]; then
                    echo "Removing existing '$home_file'"
                    rm "$home_file"
                fi
                echo "Creating symlink '$home_file' -> '$repo_file'"
                ln -s "$repo_file" "$home_file"
            done
        fi
    else
        echo "Error: Path '$path' does not exist"
        exit 1
    fi
}

sync_dir() {
    local dir_path="$(strip_trailing_slash "$(expand_path "$1")")"
    local repo_dir="$(strip_trailing_slash "$(get_repo_path "$dir_path")")"
    if [[ ! -d "$repo_dir" ]]; then
        echo "Error: '$repo_dir' not found in dotfiles repo"
        exit 1
    fi
    mkdir -p "$(dirname "$dir_path")"
    if [[ -e "$dir_path" || -L "$dir_path" ]]; then
        echo "Removing existing '$dir_path'"
        rm -rf "$dir_path"
    fi
    echo "Creating directory symlink '$dir_path' -> '$repo_dir'"
    ln -s "$repo_dir" "$dir_path"
}

is_repo_file_under_tracked_dir() {
    local repo_file="$1"
    [[ -f "$DIRS_MANIFEST" ]] || return 1
    while IFS= read -r entry; do
        [[ -z "$entry" ]] && continue
        local abs_dir="$(expand_path "$entry")"
        local repo_dir="$(get_repo_path "$abs_dir")"
        if [[ "$repo_file" == "$repo_dir"* ]]; then
            return 0
        fi
    done < "$DIRS_MANIFEST"
    return 1
}

sync_all() {
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        echo "No dotfiles found. Directory '$DOTFILES_DIR' does not exist."
        exit 0
    fi
    
    echo "Syncing all dotfiles..."

    # First, ensure directory symlinks are created
    if [[ -f "$DIRS_MANIFEST" ]]; then
        while IFS= read -r entry; do
            [[ -z "$entry" ]] && continue
            sync_dir "$(expand_path "$entry")"
        done < "$DIRS_MANIFEST"
    fi
    
    # Find all files under dotfiles/~ and create symlinks
    find "$DOTFILES_DIR" -type f | while read -r repo_file; do
        # Skip files under directories managed as full symlinks
        if is_repo_file_under_tracked_dir "$repo_file"; then
            continue
        fi
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
        add-dir)
            if [[ -z "$2" ]]; then
                echo "Error: No directory specified for add-dir command"
                usage
            fi
            add_dir "$2"
            ;;
        sync)
            if [[ -n "$2" ]]; then
                sync_file "$(expand_path "$2")"
            else
                sync_all
            fi
            ;;
        sync-dir)
            if [[ -z "$2" ]]; then
                echo "Error: No directory specified for sync-dir command"
                usage
            fi
            sync_dir "$2"
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
