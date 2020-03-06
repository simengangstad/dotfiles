set nocompatible             
filetype off                  

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()          
filetype plugin indent on

if (has("termguicolors"))
	 set termguicolors
endif


" Color theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on 
syntax enable

colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }
let g:airline_theme = 'tender'


" Clang complete
let g:clang_c_options = '-std=gnu11' 
let g:clang_cpp_options = '-std=c++17 -stdlib=libc++' 
let g:clang_cpp_competeopt = ''
let g:clang_check_syntax_auto = 1
let g:ycm_use_clangd = 0
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"

" Platform specifics
if !exists("g:os")
	let g:os = substitute(system('uname'), '\n', '', '')
endif

if g:os == "Darwin"
	let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
elseif g:os == "Linux"
	let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1'
endif

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

function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

let working_directory = FindSessionDirectory() . "/**"

execute "set path=".escape(working_directory, ' ')

" Launch 
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore | wincmd w
augroup END

