" This config was created in 2011 and originaly inspired by:
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

" Store temp files elsewhere
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Fix console vim colors
set t_Co=256

" Tabs settings
set sw=2 sts=2 et
augroup filetypes
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,slim set ai sw=2 sts=2 et
    autocmd FileType python,c,cpp,tex,htmldjango set sw=4 sts=4 et
    autocmd FileType go set sts=0 sw=4 ts=4 noet nolist
augroup END

" Use Q for formatting instead of Ex mode
map Q gq

" Show trailing whitespace
set list listchars=tab:»·,trail:·

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
set wildignore=*.pyc

" Set textwidth in text files only
autocmd FileType text setlocal textwidth=78

"""""""""""""""""""""""""""""""""""""""
" MacVim specific settings
"""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    set guifont=Monaco:h12
endif

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

" Yank to system clipboard
map <leader>y "*y

"""""""""""""""""""""""""""""""""""""""
" Text expands
"""""""""""""""""""""""""""""""""""""""
" Lazy Rubyist
iabbrev ppry require 'pry'; binding.pry
iabbrev rpry logger.info("\n***********\nPRY STARTED\n***********\n"); require 'pry-remote'; binding.remote_pry

" Lazy Pythonista
iabbrev ppdb import pdb; pdb.set_trace()
iabbrev ipdb import ipdb; ipdb.set_trace()
iabbrev rrdb from celery.contrib import rdb; rdb.set_trace()
iabbrev %debug% <pre> {% filter force_escape %} {% debug %} {% endfilter %} </pre>

"""""""""""""""""""""""""""""""""""""""
" Plugins and their setup
"""""""""""""""""""""""""""""""""""""""
" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Colorscheme options even though I don't really change this
Plug 'NLKNguyen/papercolor-theme'
Plug 'toupeira/vim-desertink'
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'

Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
" Required for Solarized to look ok
syntax enable

Plug 'scrooloose/nerdtree'
let NERDTreeHijackNetrw = 0
nmap <leader>g :NERDTreeToggle<CR>
nmap <leader>G :NERDTreeFind<CR>

" <3 Tim Pope <3
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

" ZoomWin to temporarily maximize a split
Plug 'vim-scripts/ZoomWin'
map <leader>z :ZoomWin<CR>

" Text object selection for ruby blocks
Plug 'nelstrom/vim-textobj-rubyblock'
" Required for rubyblock text objects
Plug 'kana/vim-textobj-user'

" Syntax checking and language server (CoC)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
\ 'coc-tsserver',
\ 'coc-solargraph'
\ ]

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
nmap <silent> fd <Plug>(coc-definition)
nmap <silent> fy <Plug>(coc-type-definition)
nmap <silent> fr <Plug>(coc-references)

nmap <leader>fn <Plug>(coc-rename)

nmap <leader>do <Plug>(coc-codeaction)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Buffer exploring
Plug 'vim-scripts/bufexplorer.zip'
noremap <leader>e :BufExplorerHorizontalSplit<CR>

" File/buffer search and preview via rg and ag
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
nmap g/ :Rg<space>
nmap g* :Rg <C-R><C-W>

" By default fzf :Ag and :Rg commands surround what you pass to them with
" quotes and escape the strings. I want to be able to pass directory
" information to these commands so had to dig through issues and advanced
" customization documentation to piece together some commands.
"
" As of initial commit time, I trust the Ag command more than the Rg one but
" highlighting works better with Rg.
"
" https://github.com/junegunn/fzf.vim/issues/413
" https://github.com/junegunn/fzf.vim/issues/741
" https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
command! -bang -nargs=* Rrg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, fzf#vim#with_preview(), <bang>0)

nnoremap <leader>t :GFiles<cr>
nnoremap <leader>T :Files<cr>
nnoremap <Leader>b :Buffers<cr>

" Undo tree
Plug 'mbbill/undotree'
map <leader>h ::UndotreeToggle<CR>

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

" My statusline before using airline
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

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
" Plug 'airblade/vim-gitgutter'
" Change default (4s) to show updates quickly
" set updatetime=100
Plug 'mhinz/vim-signify'

" Rspec
Plug 'thoughtbot/vim-rspec'
if has('gui_running')
    " If a gui is running, run in a terminal
    let g:rspec_command = "bin/rspec --format=progress --no-profile {spec}"
    let g:rspec_runner = "os_x_iterm2"
    nmap <Leader>rf :wa<CR> :call RunCurrentSpecFile()<CR>
    nmap <Leader>rc :wa<CR> :call RunNearestSpec()<CR>
    nmap <Leader>rr :wa<CR> :call RunLastSpec()<CR>
else
    " Didn't quickly figure out how to launch in a separate terminal
    " when using CLI vim but vim-dispatch is a better experience anyway
    nmap <Leader>rf :Dispatch rspec %<CR>
    nmap <Leader>rc :execute ":Dispatch bin/rspec %\\:" . line(".")<CR>
    nmap <Leader>rr :Copen\|Dispatch<CR>
end

" Javascript
Plug 'othree/yajs.vim'

" React/JSX
" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Elixir
Plug 'elixir-editors/vim-elixir'

" For writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
nmap <Leader>w1 :Goyo<CR>
nmap <Leader>w2 :Limelight!!<CR>

" Initialize plugin system
call plug#end()

colorscheme desertink
" let g:airline_theme='gruvbox'

"""""""""""""""""""""""""""""""""""""""
" Custom scripts
"""""""""""""""""""""""""""""""""""""""
" Functions to extract commands to paste into Docker for running
" tests with current client.
" function! FileTestCmd()
"     " Get full file path and extract only the part we need for tests
"     let l:test_path = matchlist(expand('%:p'), 'cedar\/api\/\(.*\)\.py')[1]
"     " Replace /'s with .'s to match test format
"     let l:test_path_string = substitute(l:test_path, '\/', '.', 'g')
"     " Mash together command that runs tests
"     let l:test_command = './manage.py test ' . l:test_path_string
"     " Dump this into system paste buffer
"     let @* = l:test_command
" endfunction
" nmap <Leader>pa :call FileTestCmd()<CR>

" function! FunctionTestCmd()
"     " Get full file path and extract only the part we need for tests
"     let l:test_path = matchlist(expand('%:p'), 'cedar\/api\/\(.*\)\.py')[1]
"     " Replace /'s with .'s to match test format
"     let l:test_path_string = substitute(l:test_path, '\/', '.', 'g')

"     " Get text line of most recent root level class definition
"     let l:class_line = getline(search('^class', 'nb'))
"     " Extract class name
"     let l:class_name = matchlist(l:class_line, '^class \(.*\)(')[1]

"     " Get the value of the function name which will be most recent
"     " method name starting with test_
"     let l:function_line = getline(search('^\s*def test_', 'nb'))
"     " Extract function name
"     let l:function_name = matchlist(l:function_line, '^\s*def \(.*\)(')[1]

"     " Mash together command that runs tests
"     let l:test_command = './manage.py test ' . l:test_path_string . '.' . l:class_name . '.' . l:function_name

"     " Dump this into system paste buffer
"     let @* = l:test_command
" endfunction
" nmap <Leader>pc :call FunctionTestCmd()<CR>

nnoremap zs :set foldmethod=syntax<CR>
nnoremap zw :set foldmethod=indent<CR>

" Vim helpers for Claude Code references (written by Claude Code!)
" <leader>al -- Copy path of line with line number
" <leader>as -- Copy path of visual selection with line number range

function! CopyLineForClaude()
  let filename = expand('%:.')
  let linenumber = line('.')
  let codesnippet = getline('.')
  let formatted = filename . ':' . linenumber . "\n```\n" . codesnippet . "\n```"
  let @+ = formatted
  let @* = formatted
  echo 'Copied: ' . filename . ':' . linenumber
endfunction

function! CopySelectionForClaude() range
  let filename = expand('%:.')
  let start_line = a:firstline
  let end_line = a:lastline

  " Get all lines in the selection
  let lines = getline(start_line, end_line)
  let codesnippet = join(lines, "\n")

  " Format with line range
  if start_line == end_line
    let line_info = start_line
  else
    let line_info = start_line . '-' . end_line
  endif

  let formatted = filename . ':' . line_info . "\n```\n" . codesnippet . "\n```"
  let @+ = formatted
  let @* = formatted
  echo 'Copied: ' . filename . ':' . line_info . ' (' . len(lines) . ' lines)'
endfunction


nnoremap <leader>al :call CopyLineForClaude()<CR>
vnoremap <leader>as :call CopySelectionForClaude()<CR>
