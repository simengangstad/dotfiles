if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible             
filetype on

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'govim/govim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

Plug 'jacoborus/tender.vim'
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

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
hi Normal guifg=#eeeeee ctermfg=255 guibg=#1d1d1d ctermbg=235 gui=NONE cterm=NONE


" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 25 
let g:netrw_browse_split = 4
let g:netrw_altv=1


" General
set mouse=a
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set backspace=indent,eol,start
set ruler
set number
set noshowmode
set colorcolumn=80
set laststatus=2
set ignorecase
set smartcase
set incsearch
set hlsearch
set t_Co=256
set signcolumn=number



function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

let working_directory = FindSessionDirectory() . "/**"

execute "set path=".escape(working_directory, ' ')


function! Omni()
    call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
                    \ 'name': 'omni',
                    \ 'whitelist': ['go'],
                    \ 'completor': function('asyncomplete#sources#omni#completor')
                    \  }))
endfunction

au VimEnter * :call Omni()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
