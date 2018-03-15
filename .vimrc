" Inspired by:
" https://github.com/edgecase/vim-config/
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

"""""""""""""""""""""""""""""""""""""""
" General setup
"""""""""""""""""""""""""""""""""""""""
set nocompatible
syntax on
set number          " Show line numbers
set mouse=a         " Enable mouse
set colorcolumn=80  " Always highlight 80th
set ruler           " Always show cursor
set showmatch       " Show matching paren
set history=1000    " Long history
set ignorecase      " Ignore case in search
set smartcase       " ... unless there are caps
set laststatus=2    " Always show status line
set incsearch       " Show first match as search is typed
set hlsearch        " Highlight all search matches
set hidden          " Important for keeping history when switching buffers

" Kick on Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Fix console vim colors
set t_Co=256

Plugin 'toupeira/vim-desertink'
colorscheme desertink
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
" command! Dark :set background=dark | colorscheme solarized
" command! Light :set background=light | colorscheme solarized

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Elixir
Plugin 'elixir-editors/vim-elixir'

" Tabs settings
set sw=2 sts=2 et
augroup filetypes
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,slim set ai sw=2 sts=2 et
    autocmd FileType python,c,cpp,tex,htmldjango set sw=4 sts=4 et
augroup END

" Store temp files elsewhere
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Use Q for formatting instead of Ex mode
map Q gq

" Show trailing whitespace
set list listchars=tab:»·,trail:·

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
set wildignore=*.pyc

"""""""""""""""""""""""""""""""""""""""
" General key mappings
"""""""""""""""""""""""""""""""""""""""
" Clear search highlights
nnoremap <leader><space> :nohlsearch<CR>

" Select last paste or modified set of lines
nnoremap vv `[V`]

" Hide trailing whitespace annotations
nmap <silent> <leader>s :set nolist!<CR>

" Kill trailing whitespace
map <leader>c :%s/\s\+$<cr>

" Make Y consistent with C and D
nnoremap Y y$

" Hash rocket insertion
imap <C-l> <Space>=><Space>

" Delete all buffers
map <leader>B :bufdo bd<cr>

" Better switch split bindings
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"""""""""""""""""""""""""""""""""""""""
" Text expands
"""""""""""""""""""""""""""""""""""""""
" Lazy Rubyist
iabbrev ppry require 'pry'; binding.pry
iabbrev rpry logger.info("\n***********\nPRY STARTED\n***********\n"); require 'pry-remote'; binding.remote_pry
iabbrev rdebug require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger; 0;

" Lazy Pythonista
iabbrev ppdb import pdb; pdb.set_trace()
iabbrev ipdb import ipdb; ipdb.set_trace()
iabbrev rrdb from celery.contrib import rdb; rdb.set_trace()

"""""""""""""""""""""""""""""""""""""""
" Plugins and their setup
"""""""""""""""""""""""""""""""""""""""
" Handlebars, Mustache, and Friends
" Plugin 'mustache/vim-mustache-handlebars'
" au BufNewFile,BufRead *.mustache,*.handlebars,*.hbs,*.hb set filetype=mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

" Coffee
" Plugin 'kchmck/vim-coffee-script'
" au! BufRead,BufNewFile *.coffee set filetype=coffee

Plugin 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 0
nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>


" <3 Tim Pope <3
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-projectionist'

" ZoomWin to temporarily maximize a split
Plugin 'vim-scripts/ZoomWin'
map <leader>z :ZoomWin<CR>

" Text object selection for ruby blocks
Plugin 'nelstrom/vim-textobj-rubyblock'
" Required for rubyblock text objects
Plugin 'kana/vim-textobj-user'

" Syntax checking
" This requires associated syntax checkers to be
" installed (such as flake8 for Python)
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_python_exec = 'python3'

" Buffer exploring
Plugin 'vim-scripts/bufexplorer.zip'
noremap <leader>e :BufExplorerHorizontalSplit<CR>

Plugin 'ctrlpvim/ctrlp.vim'
nnoremap <leader>b :<C-U>CtrlPBuffer<CR>
nnoremap <leader>t :<C-U>CtrlP<CR>
nnoremap <leader>T :<C-U>CtrlPTag<CR>
" Toggle working path mode (important for submodules)
map <leader>p :let g:ctrlp_working_path_mode = 'a'<cr>
map <leader>P :let g:ctrlp_working_path_mode = 'ra'<cr>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" Respect the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
" Don't jump to open buffers in other tabs
let g:ctrlp_switch_buffer = 0

" Undo tree
Plugin 'sjl/gundo.vim'
map <leader>h :GundoToggle<CR>

" AG for search
Plugin 'rking/ag.vim'
nmap g/ :Ag!<space>
nmap g* :Ag! -w <C-R><C-W><space>
nmap ga :AgAdd!<space>
nmap gq :ccl<CR>
nmap gl :cwindow<CR>
" Install ack as well due to --type being helpful
Plugin 'mileszs/ack.vim'

" Tagbar for navigation by tags using CTags
Plugin 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
map <leader>rt :!ctags --extra=+f -R *<CR><CR>
map <leader>. :TagbarToggle<CR>

" Lightweight status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Don't also show default mode indicators
set noshowmode
" Show buffers bar if only one tab is open
" let g:airline#extensions#tabline#enabled = 1
" Hide the file type/encoding
let g:airline_section_y = ''

" Parse coverage reports
" Plugin 'alfredodeza/coveragepy.vim'

" Install tabular and set up common tabulated shortcuts
Plugin 'godlygeek/tabular'
function! CustomTabularPatterns()
    if exists('g:tabular_loaded')
        AddTabularPattern! symbols         / :/l0
        AddTabularPattern! hash            /^[^>]*\zs=>/
        AddTabularPattern! chunks          / \S\+/l0
        AddTabularPattern! assignment      / = /l0
        AddTabularPattern! comma           /^[^,]*,/l1
        AddTabularPattern! colon           /:\zs /l0
        AddTabularPattern! options_hashes  /:\w\+ =>/
    endif
endfunction
autocmd VimEnter * call CustomTabularPatterns()

" Show git info in gutter
Plugin 'airblade/vim-gitgutter'
" Change default (4s) to show updates quickly
set updatetime=100

" Clojure
" Plugin 'guns/vim-clojure-static'
" Plugin 'kien/rainbow_parentheses.vim'
" Plugin 'tpope/vim-fireplace'
" autocmd FileType clojure RainbowParenthesesActivate
" autocmd FileType clojure RainbowParenthesesLoadRound
" autocmd FileType clojure RainbowParenthesesLoadSquare
" autocmd FileType clojure RainbowParenthesesLoadBraces

" Rspec
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
let g:rspec_command = "Dispatch bundle exec rspec --format=progress --no-profile {spec}"
nmap <Leader>rc :wa<CR> :call RunCurrentSpecFile()<CR>
nmap <Leader>rn :wa<CR> :call RunNearestSpec()<CR>
nmap <Leader>rl :wa<CR> :call RunLastSpec()<CR>
nmap <Leader>ra :wa<CR> :call RunAllSpecs()<CR>

" Javascript
" Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
" Plugin 'jelera/vim-javascript-syntax'

" React/JSX
Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Has to be called before any plugin commands
call vundle#end()
filetype plugin indent on

" Set textwidth in text files only
autocmd FileType text setlocal textwidth=78
