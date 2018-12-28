# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# ZSH_THEME="robbyrussell"
# ZSH_THEME="materialshell"
# ZSH_THEME="spaceship"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
#DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git history colorize)
plugins=(git screen colorize z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/Dropbox/dotfiles/aws.zsh
source ~/Dropbox/dotfiles/.keys.zsh

export JAVA_HOME="$(/usr/libexec/java_home)"
# export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk*.pem | /usr/bin/head -1)"
# export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert*.pem | /usr/bin/head -1)"

export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.6.12.0/libexec"
export EC2_REGION="us-west-2"
export EC2_URL="https://ec2.us-west-2.amazonaws.com"
export EVENT_NOKQUEUE=1

export GOROOT=/usr/local/go

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:./node_modules/.bin:~/.ec2/bin:/Users/eduardosasso/Dropbox/android-sdk-macosx:/Users/eduardosasso/Dropbox/android-sdk-macosx/platforms:/Users/eduardosasso/Dropbox/android-sdk-macosx/tools:$GEM_HOME/bin:$PATH:$GOROOT/bin

export VISUAL=nvim
export EDITOR="$VISUAL"

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export NODE_PATH=/usr/local/lib/node_modules

alias vim='nvim'
alias gdiff='git diff'
alias gcm='git commit -v -a -m'
alias gdisc='git checkout -- .'

alias trip='cd /Users/eduardosasso/Dropbox/gogobot/trip-rails-app'
alias gbot='cd /Users/eduardosasso/Dropbox/gogobot'
alias leter='cd /Users/eduardosasso/dropbox/leter'

# top 20 most recent branches
alias gbr="git for-each-ref --count=20 --sort=-committerdate refs/heads/ --format='%(refname)' | sed 's/refs\/heads\///g'"

export ARDUINODIR=/Applications/Arduino.app/Contents/Resources/Java
export BOARD=mega2560

bindkey '^[[Z' autosuggest-accept 

autoload -U promptinit; promptinit
prompt pure

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/Dropbox/dotfiles/.fzf.zsh ] && source ~/Dropbox/dotfiles/.fzf.zsh
