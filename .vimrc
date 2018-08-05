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
set nojoinspaces    " Don't add extra spaces on line joining with punctuation

" Don't make backup files
set nobackup
set nowritebackup

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Fix console vim colors
set t_Co=256

" TODO move this stuff?
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Tabs settings
set sw=2 sts=2 et
augroup filetypes
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,slim set ai sw=2 sts=2 et
    autocmd FileType python,c,cpp,tex,htmldjango set sw=4 sts=4 et
    autocmd FileType go set sts=0 sw=4 ts=4 noet nolist
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

" Set textwidth in text files only
autocmd FileType text setlocal textwidth=78

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
" Initialize vim-plug
call plug#begin('~/.vim/plugged')

Plug 'toupeira/vim-desertink'
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
Plug 'NLKNguyen/papercolor-theme'

Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 0
nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>

" <3 Tim Pope <3
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-projectionist'

" ZoomWin to temporarily maximize a split
Plug 'vim-scripts/ZoomWin'
map <leader>z :ZoomWin<CR>

" Text object selection for ruby blocks
Plug 'nelstrom/vim-textobj-rubyblock'
" Required for rubyblock text objects
Plug 'kana/vim-textobj-user'

" Syntax checking
" This requires associated syntax checkers to be
" installed (such as flake8 for Python)
" Plug 'scrooloose/syntastic'
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_python_python_exec = 'python3'
" let g:syntastic_python_checkers = ['pylama']
Plug 'w0rp/ale'
let g:ale_linters = {
\   'python': ['pyflakes', 'pycodestyle'],
\}
let g:ale_python_pycodestyle_options = "--ignore=E501,E266"

" Buffer exploring
Plug 'vim-scripts/bufexplorer.zip'
noremap <leader>e :BufExplorerHorizontalSplit<CR>

Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'sjl/gundo.vim'
map <leader>h :GundoToggle<CR>

" AG for search
Plug 'rking/ag.vim'
nmap g/ :Ag!<space>
nmap g* :Ag! -w <C-R><C-W><space>
nmap ga :AgAdd!<space>
nmap gq :ccl<CR>
nmap gl :cwindow<CR>
" Install ack as well due to --type being helpful
Plug 'mileszs/ack.vim'

" Tagbar for navigation by tags using CTags
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
map <leader>rt :!ctags --extra=+f -R *<CR><CR>
map <leader>. :TagbarToggle<CR>

" Lightweight status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Don't also show default mode indicators
set noshowmode
" Show buffers bar if only one tab is open
" let g:airline#extensions#tabline#enabled = 1
" Hide the file type/encoding
let g:airline_section_y = ''
let g:airline#extensions#branch#displayed_head_limit = 15

" Install tabular and set up common tabulated shortcuts
Plug 'godlygeek/tabular'
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
Plug 'airblade/vim-gitgutter'
" Change default (4s) to show updates quickly
set updatetime=100

" Rspec
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
let g:rspec_command = "Dispatch bundle exec rspec --format=progress --no-profile {spec}"
nmap <Leader>rc :wa<CR> :call RunCurrentSpecFile()<CR>
nmap <Leader>rn :wa<CR> :call RunNearestSpec()<CR>
nmap <Leader>rl :wa<CR> :call RunLastSpec()<CR>
nmap <Leader>ra :wa<CR> :call RunAllSpecs()<CR>

" Javascript
Plug 'othree/yajs.vim'

" React/JSX
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Elixir
Plug 'elixir-editors/vim-elixir'

" Golang
Plug 'fatih/vim-go'

" For writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Initialize plugin system
call plug#end()

colorscheme PaperColor

"""""""""""""""""""""""""""""""""""""""
" Custom scripts
"""""""""""""""""""""""""""""""""""""""
" Functions to extract commands to paste into Docker for running
" tests with current client.
function! FileTestCmd()
    " Get full file path and extract only the part we need for tests
    let l:test_path = matchlist(expand('%:p'), 'cedar\/api\/\(.*\)\.py')[1]
    " Replace /'s with .'s to match test format
    let l:test_path_string = substitute(l:test_path, '\/', '.', 'g')
    " Mash together command that runs tests
    let l:test_command = './manage.py test ' . l:test_path_string
    " Dump this into system paste buffer
    let @* = l:test_command
endfunction
nmap <Leader>pa :call FileTestCmd()<CR>

function! FunctionTestCmd()
    " Get full file path and extract only the part we need for tests
    let l:test_path = matchlist(expand('%:p'), 'cedar\/api\/\(.*\)\.py')[1]
    " Replace /'s with .'s to match test format
    let l:test_path_string = substitute(l:test_path, '\/', '.', 'g')

    " Get text line of most recent root level class definition
    let l:class_line = getline(search('^class', 'nb'))
    " Extract class name
    let l:class_name = matchlist(l:class_line, '^class \(.*\)(')[1]

    " Get the value of the function name which will be most recent
    " method name starting with test_
    let l:function_line = getline(search('^\s*def test_', 'nb'))
    " Extract function name
    let l:function_name = matchlist(l:function_line, '^\s*def \(.*\)(')[1]

    " Mash together command that runs tests
    let l:test_command = './manage.py test ' . l:test_path_string . '.' . l:class_name . '.' . l:function_name

    " Dump this into system paste buffer
    let @* = l:test_command
endfunction
nmap <Leader>pc :call FunctionTestCmd()<CR>
