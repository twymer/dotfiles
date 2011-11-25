# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/twymer/.rvm/gems/macruby-0.10/bin:/Users/twymer/.rvm/gems/macruby-0.10@global/bin:/Users/twymer/.rvm/rubies/macruby-0.10/bin:/Users/twymer/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# Kill autocorrect nonsense
unsetopt correct_all

# **********
# My things
# **********

# Alias to link all frameworks in for SFML when compiling
alias f++='g++ -framework sfml-audio -framework sfml-graphics -framework sfml-network -framework sfml-system -framework sfml-window'

# alias redcar to the rvm wrapper
alias redcar='wrapped_redcar'

# use vim compiled for macvim instead of system
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# Random project shortcuts
alias ypgems='rvm use 1.9.2@webyp'
alias yp='cd ~/code/work/edgecase/webyp/ && ypgems'
alias ss='script/server'
alias ssd='script/server --debugging'
alias buzzgems='rvm use 1.8.7@buzz'
alias buzz='cd ~/code/work/edgecase/buzz/ && buzzgems'

