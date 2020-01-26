let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 20
let g:netrw_browse_split = 4
let g:netrw_altv=1

set mouse=a
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set textwidth=120
set backspace=indent,eol,start
set ruler
set number
set path=$PWD/**

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore | wincmd w
augroup END

syntax on

