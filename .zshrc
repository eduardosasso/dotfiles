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

# Example aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

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
# Customize to your needs...
# export PATH=/Users/eduardosasso/.rvm/gems/ruby-1.9.3-p194@gogo_web/bin:/Users/eduardosasso/.rvm/gems/ruby-1.9.3-p194@global/bin:/Users/eduardosasso/.rvm/rubies/ruby-1.9.3-p194/bin:/Users/eduardosasso/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:./node_modules/.bin/

export JAVA_HOME="$(/usr/libexec/java_home)"
# export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk*.pem | /usr/bin/head -1)"
# export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert*.pem | /usr/bin/head -1)"
export AWS_ACCESS_KEY="AKIAJ5VOGD4C5J43NZAQ"
export AWS_SECRET_KEY="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"
export AWS_SECRET_ACCESS_KEY="1D+pX3C/okhTLaOqpdqv3rNCHFWw2j3X8H/hERTc"
# export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.6.12.0/libexec"
export EC2_REGION="us-west-2"
export EC2_URL="https://ec2.us-west-2.amazonaws.com"
export BUNDLE_EDITOR="subl -w"
export EVENT_NOKQUEUE=1

export DO_API_KEY=7f5365f5842c356f30513657f35c5819d52be77d6d0abeb702066a113be50bc9

export GOROOT=/usr/local/go
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:./node_modules/.bin:~/.ec2/bin:/Users/eduardosasso/Dropbox/android-sdk-macosx:/Users/eduardosasso/Dropbox/android-sdk-macosx/platforms:/Users/eduardosasso/Dropbox/android-sdk-macosx/tools:$GEM_HOME/bin:$PATH:$GOROOT/bin

export VISUAL=nvim
export EDITOR="$VISUAL"

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export NODE_PATH=/usr/local/lib/node_modules

export SEKRETS_KEY=fc84df4718bc2bf2e7f77ecd88af6fcf

alias vim='nvim'
alias gdiff='git diff'
alias gcm='git commit -v -a -m'
alias gdisc='git checkout -- .'
# alias gpr='git pull-request -b gogobot:master -h gogobot:$(current_branch)'

alias trip='cd /Users/eduardosasso/Dropbox/gogobot/trip-rails-app'
alias gbot='cd /Users/eduardosasso/Dropbox/gogobot'
alias leter='cd /Users/eduardosasso/dropbox/leter'

# staging  (Oregon Availability Zone - make sure to provide your personal public key for authentication)
# alias gogobot_dev='ssh ec2-user@54.245.92.244'
# alias gogobot_mdev='ssh ec2-user@54.245.92.245'
# alias gogobot_stg='ssh ec2-user@54.245.92.243'

# alias refssh='ssh root@69.164.201.65'
# alias showt='ssh root@173.255.199.136'

# alias trip='cd /Users/eduardosasso/Dropbox/trip-compass'

# top 20 most recent branches
alias gbr="git for-each-ref --count=20 --sort=-committerdate refs/heads/ --format='%(refname)' | sed 's/refs\/heads\///g'"

export ARDUINODIR=/Applications/Arduino.app/Contents/Resources/Java
export BOARD=mega2560

export DRONE_SERVER=https://drone-github.skyscannertools.net
export DRONE_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZXh0IjoiZWR1YXJkb3Nhc3NvIiwidHlwZSI6InVzZXIifQ.QySUDq9UfCKZpMFh6svc_eXxXsmLq7NTS-s1k26nFgE

# export RUBY_HEAP_MIN_SLOTS=2000000
# export RUBY_HEAP_SLOTS_INCREMENT=10000
# export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.8
# export RUBY_GC_MALLOC_LIMIT=100000000
# export RUBY_HEAP_FREE_MIN=100000

# fpath=(~/.oh-my-zsh/Completion $fpath)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# . "/Users/eduardosasso/.acme.sh/acme.sh.env"
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # Set Spaceship ZSH as a prompt
  # autoload -U promptinit; promptinit
  # prompt spaceship

bindkey '^[[Z' autosuggest-accept 

autoload -U promptinit; promptinit
prompt pure

# POWERLEVEL9K_PROMPT_ON_NEWLINE=false
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
# POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes)
# source "/Users/eduardosasso/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
