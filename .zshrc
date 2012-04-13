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

# Fix terminal coloring
# alias tmux="tmux -2"
alias tmux="TERM=screen-256color-bce tmux"

alias ls='ls -G'
alias ll='ls -lG'
alias duh='du -csh'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Customize to your needs...
#export PATH=/Users/twymer/.rvm/gems/macruby-0.10/bin:/Users/twymer/.rvm/gems/macruby-0.10@global/bin:/Users/twymer/.rvm/rubies/macruby-0.10/bin:/Users/twymer/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# Kill autocorrect nonsense
unsetopt correct_all


# Alias to link all frameworks for sdl/sfml
alias f++='g++ -framework sfml-audio -framework sfml-graphics -framework sfml-network -framework sfml-system -framework sfml-window'
alias cc-sdl='cc -lSDLmain -lSDL -lSDL_image -framework Cocoa'
alias cc-opengl-sdl='cc -lSDLmain -lSDL -framework OpenGL -framework Cocoa'
alias cpp-sdl='g++ -lSDLmain -lSDL -lSDL_image -framework Cocoa'

# alias redcar to the rvm wrapper
alias redcar='wrapped_redcar'

# use vim compiled for macvim instead of system
# alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

alias start_mysql='/usr/local/Cellar/mysql/5.5.15/bin/mysqld_safe'

# Random project shortcuts
alias teamster='rvm use 1.9.3 && cd ~/code/work/edgecase/teamster/'
alias site='rvm use 1.9.3@blog && cd ~/code/personal-site'
alias ss='script/server'
alias ssd='script/server --debugging'

