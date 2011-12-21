source ~/.zsh/functions/zsh_recompile.zsh

autoload -U compinit promptinit
setopt promptsubst
compinit
promptinit
prompt grb

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
# Ignore duplicate in history.
setopt hist_ignore_dups
# Prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

# Unbreak broken, non-colored terminal
# export TERM='xterm-color'
alias ls='ls -G'
alias ll='ls -lG'
alias duh='du -csh'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Customize to your needs...
export PATH=/Users/twymer/.rvm/gems/macruby-0.10/bin:/Users/twymer/.rvm/gems/macruby-0.10@global/bin:/Users/twymer/.rvm/rubies/macruby-0.10/bin:/Users/twymer/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# Kill autocorrect nonsense
unsetopt correct_all


# Alias to link all frameworks for sdl/sfml
alias f++='g++ -framework sfml-audio -framework sfml-graphics -framework sfml-network -framework sfml-system -framework sfml-window'
alias cc-sdl='cc -lSDLmain -lSDL -framework Cocoa'

# alias redcar to the rvm wrapper
alias redcar='wrapped_redcar'

# use vim compiled for macvim instead of system
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

alias start_mysql='/usr/local/Cellar/mysql/5.5.15/bin/mysqld_safe'

# Random project shortcuts
alias ypgems='rvm use 1.9.2@webyp'
alias yp='cd ~/code/work/edgecase/webyp/ && ypgems'
alias ss='script/server'
alias ssd='script/server --debugging'
alias buzzgems='rvm use 1.8.7@buzz'
alias buzz='cd ~/code/work/edgecase/buzz/ && buzzgems'

