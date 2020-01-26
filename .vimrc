set nocompatible             
filetype off                  

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jacoborus/tender.vim'

call vundle#end()          
filetype plugin indent on

if (has("termguicolors"))
	 set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

syntax on 
syntax enable
colorscheme tender

let g:lightline = { 'colorscheme': 'tender' }
let g:airline_theme = 'tender'


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

