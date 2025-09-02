# Set Ghostty tab/window title to current folder name
function fish_title
    echo (basename $PWD)
end
