if status is-interactive
    # Commands to run in interactive sessions can go here
    # Ctrl+K to clear screen (like macOS Cmd+K)
    bind \ck 'clear; commandline -f repaint'
end

alias l='eza --long --group-directories-first --colour-scale=all --hyperlink -a --color=always'
alias ll='l'

alias ga='git add'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gss='git status -s'
alias ggpull='git pull origin (git symbolic-ref --short HEAD)'
alias gd='git diff'
alias glog='git log --oneline --decorate'
alias gb='git branch'
alias gdiff='git diff'
alias ggpush='git push origin (git branch --show-current)'

set -gx BAT_THEME "Coldark-Dark"
set -g fish_greeting ""
set -Ux EZA_COLORS "reset:di=36:uu=0:un=0:gu=0:gn=0:xx=0:da=90:sn=90:ur=0:uw=0:ux=0:ue=0:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0"

# fnm env --use-on-cd --shell fish | source
fish_add_path /opt/homebrew/opt/node@22/bin
fish_add_path $HOME/.local/bin

# [ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Async git fetch helper function
function _async_git_fetch
    set repo_path (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_path"
        return
    end

    set fetch_file "$repo_path/.git/FETCH_HEAD"
    set current_time (date +%s)
    set fetch_interval 300  # 5 minutes

    # Check if we need to fetch (no previous fetch or older than interval)
    set should_fetch false
    if not test -f $fetch_file
        set should_fetch true
    else
        set last_fetch (stat -c %Y $fetch_file 2>/dev/null || echo 0)
        if test (math $current_time - $last_fetch) -gt $fetch_interval
            set should_fetch true
        end
    end

    # Start background fetch if needed
    if test $should_fetch = true
        # Fork a background process that won't block the prompt
        fish -c "cd '$repo_path' && git fetch --quiet >/dev/null 2>&1" &
        disown
    end
end

function fish_prompt
    set_color cyan
    echo -n (prompt_pwd) ""

    # Early exit if not in git repo
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo -n " ❯ "
        return
    end

    # Async fetch - runs in background every 5 minutes
    _async_git_fetch

    # Get all git info in one go using git status --porcelain
    set git_status_output (git status --porcelain=v1 --branch --ahead-behind 2>/dev/null)

    if test -z "$git_status_output"
        echo -n " ❯ "
        return
    end

    # Split into lines
    set git_lines (string split \n $git_status_output)
    set branch_line $git_lines[1]

    # Parse branch info from first line
    set branch (echo $branch_line | sed 's/^## //' | sed 's/\.\.\..*//')

    # Check for dirty files - any lines beyond the first indicate changes
    set dirty ""
    if test (count $git_lines) -gt 1
        set dirty "✦"
    end

    # Parse ahead/behind info from branch line
    set upstream_status ""
    if string match -q "*ahead*" $branch_line
        if string match -q "*behind*" $branch_line
            set upstream_status " ↕"  # both ahead and behind
        else
            set upstream_status " ⇡"  # ahead only
        end
    else if string match -q "*behind*" $branch_line
        set upstream_status " ⇣"  # behind only
    end

    # Display branch name
    set_color brblack
    echo -n $branch

    # Display dirty indicator
    if test -n "$dirty"
        set_color magenta
        echo -n $dirty
    end

    # Display upstream status
    if test -n "$upstream_status"
        set_color magenta
        echo -n $upstream_status
    end

    set_color normal
    echo -n " ❯ "
end

zoxide init fish | source
