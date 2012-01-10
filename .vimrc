" Inspired by:
" https://github.com/edgecase/vim-config/
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc


" Kill compatibility
set nocompatible

" For plugins
filetype off

" Kick on Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'



" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    set guifont=Monaco:h15
endif

" Fix console vim colors
set t_Co=256

set background=dark
colorscheme desertink

" Cursor crosshairs!
set cursorcolumn
set cursorline

" Always show line numbers
set number

" Tabs settings
set sw=2 sts=2 et
augroup filetypes
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
    autocmd FileType python,c,cpp set sw=4 sts=4 et
augroup END

" Enable mouse
set mouse=a

" Store temp files elsewhere
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Searches not case-sensitive unless caps are used
set ignorecase
set smartcase

" Long history
set history=1000
set undolevels=1000

" Allow unwritten background buffers
set hidden

" Use Q for formatting instead of Ex mode
map Q gq

" Show first match as search is typed
set incsearch
" Highlight all search matches
set hlsearch
" Now let us clear these annyoing highlights easily
" EC way
nnoremap <leader><space> :nohlsearch<CR>
" My way
nnoremap <CR> :nohlsearch<CR><CR>

" Show trailing whitespace
set list listchars=tab:»·,trail:·
" Hide them with leader s
nmap <silent> <leader>s :set nolist!<CR>

" Always show cursor
set ruler

" Show matching paren
set showmatch

" Kill trailing whitespace
map <Leader>c :%s/\s\+$<cr>

" Make Y consistent with C and D
nnoremap Y y$

" Lazy rubyist
imap <C-l> <Space>=><Space>
iabbrev rdebug require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger; 0;

" Insert blank lines without going into insert mode
nmap go o<esc>
nmap gO O<esc>

" Jump to previous buffer with g-enter
" (significant whitespace on next line)
nmap g 

" Better switch split bindings
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

if has("autocmd")
    " Filetype detection
    filetype plugin indent on

    " Set textwidth in text files only
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

if has("gui_running")
    " Hide the toolbar
    set go-=T

    " Don't show scrollbars
    set guioptions-=L
    set guioptions-=r
endif

" Plugins
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'vim-scripts/ZoomWin'
  map <Leader>z :ZoomWin<CR>
Bundle 'tpope/vim-repeat'
" Repeat actions that were done from plugins
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
" :Rake
Bundle 'tpope/vim-rake'
" Add 'end' in ruby
Bundle 'tpope/vim-endwise'
" Text object selection for ruby blocks
Bundle 'nelstrom/vim-textobj-rubyblock'
" Required for rubyblock text objects
Bundle 'kana/vim-textobj-user'
" % matching for html and several other languages
Bundle 'edsono/vim-matchit'
" Easy commenting
Bundle 'scrooloose/nerdcommenter'
" Colorschemes
Bundle 'altercation/vim-colors-solarized'
Bundle 'toupeira/vim-desertink'


Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 0
nmap gt :NERDTreeToggle<CR>

Bundle 'godlygeek/tabular'
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

Bundle 'wincent/Command-T'

" ACK
Bundle 'mileszs/ack.vim'
    nmap g/ :Ack!<space>
    nmap g* :Ack! -w <C-R><C-W><space>
    nmap ga :AckAdd!<space>
    nmap gn :cnext<CR>
    nmap gp :cprev<CR>
    nmap gq :ccl<CR>
    nmap gl :cwindow<CR>


" Status line
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
