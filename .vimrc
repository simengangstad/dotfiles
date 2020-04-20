if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible             
filetype off                  

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'jacoborus/tender.vim'
Plug 'Valloric/YouCompleteMe', {'for': ['c', 'cpp']}
Plug 'itchyny/lightline.vim'
call plug#end()

if (has("termguicolors"))
	 set termguicolors
endif


" Color theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on 
syntax enable

colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }



" YCM 
let g:ycm_use_clangd = 0
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
set completeopt-=preview


" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 20
let g:netrw_browse_split = 4
let g:netrw_altv=1


" General
set mouse=a
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set textwidth=120
set backspace=indent,eol,start
set ruler
set number
set clipboard=unnamed
set noshowmode
set laststatus=2
set ignorecase
set smartcase
set incsearch
set hlsearch


function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

let working_directory = FindSessionDirectory() . "/**"

execute "set path=".escape(working_directory, ' ')

