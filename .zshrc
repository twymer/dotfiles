source ~/.zsh/functions/zsh_recompile.zsh

# Before other PATHs...
PATH=${PATH}:/usr/local/share/python

# Python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
else
  echo "WARNING: Can't find virtualenvwrapper.sh"
fi

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

# use vim compiled for macvim instead of system
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# use exhuberant ctags properly
export PATH="/usr/local/bin:$PATH"

# Random project related shortcuts
alias ss='script/server'
alias ssd='script/server --debugging'
alias sourcehq='workon hq_env15'
alias starthq='bash dotfiles/bin/starthq.sh'
alias hq='cd ~/code/dimagi/commcare-hq && sourcehq'
alias flipit='python manage.py ptop_es_manage --flip_all_aliases'
alias fluffit='./manage.py syncdb && ./manage.py reset_pillowtop_checkpoints && ./manage.py run_ptop'

alias pip='ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future pip'
