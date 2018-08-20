set guifont=Monaco:h12

" Hide the toolbar
set go-=T

" Don't show scrollbars
set guioptions-=L
set guioptions-=r

" Use console style tabs
set guioptions-=e
" This is a bit of a hack because the default was a super light gray
" so this color matches the dark gray NonText color that is set for desertink..
hi TabLine term=underline cterm=underline ctermfg=15 ctermbg=8 gui=underline guibg=#3D3D3D
