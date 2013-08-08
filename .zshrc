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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

source /usr/local/bin/virtualenvwrapper.sh

# Set editor mode for tmuxinator
export EDITOR=vim
# But setting editor to vim triggers vi-mode which kills the
# ctrl-r shortcut so fix that up
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

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
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

alias start_mysql='/usr/local/Cellar/mysql/5.5.25/bin/mysqld_safe'

# Random project related shortcuts
alias ss='script/server'
alias ssd='script/server --debugging'
alias sourcehq='source ~/.virtualenvs/commcare-hq/bin/activate'
alias hq='cd ~/code/dimagi/commcare-hq && sourcehq'
alias flipit='python manage.py ptop_es_manage --flip_all_aliases'
alias fluffit='./manage.py syncdb && ./manage.py reset_pillowtop_checkpoints && ./manage.py run_ptop'
