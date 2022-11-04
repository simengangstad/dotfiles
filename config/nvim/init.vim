set nocompatible
filetype plugin indent on

" -------------------------------- Plugins ------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'sbdchd/neoformat'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'simrat39/rust-tools.nvim'

Plug 'tikhomirov/vim-glsl'

Plug 'lervag/vimtex'

Plug 'vimwiki/vimwiki'

call plug#end()

packadd termdebug

" -------------------------------- Color theme --------------------------------
syntax enable

colorscheme nord

let g:nord_cursor_line_number_background = 1
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'right': [['lineinfo']],
    \ },
    \ 'inactive': {
    \   'right': [['lineinfo']],
    \ },
    \ }

" Make splits have fill chars
set fillchars+=vert:\|,

" -------------------------------- General ------------------------------------
set splitright
set mouse=a
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set backspace=indent,eol,start
set ruler
set number
set noshowmode
set ignorecase
set smartcase
set incsearch
set hlsearch
set encoding=UTF-8

" Set fold to indent and not to automatically fold
set foldmethod=indent
set nofoldenable

" Always show status line
set laststatus=2

" Hide the current command
set noshowcmd

" Use xterm-256
set t_Co=256


" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Leader space removes highlight
nnoremap <Leader><space> :noh<CR>

" Make
nnoremap <Leader>mm :make -j <CR>
nnoremap <Leader>mc :make clean <CR>
nnoremap <Leader>mf :make flash <CR>

" Close all buffers besides the current one
nnoremap <Leader>cc :w\|%bd\|e# <CR><Esc>

" -------------------------------- NERDTree -----------------------------------
let NERDTreeMinimalUI=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" -------------------------------- Terminal -----------------------------------
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Mapping for linux
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(13)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Mapping for macOS (this is Alt-t)
nnoremap † :call TermToggle(12)<CR>
inoremap † <Esc>:call TermToggle(12)<CR>
tnoremap † <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" -------------------------------- CtrlP -------------------------------------

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

nnoremap <Leader>cp :CtrlPClearAllCaches<CR>


" -------------------------------- Neoformat ---------------------------------

let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style="{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true, FixNamespaceComments: false, NamespaceIndentation: All, AlignConsecutiveAssignments: true, AlignEscapedNewlines: true, AlignOperands: Align, AlignTrailingComments: true, AllowAllParametersOfDeclarationOnNextLine: false, AllowAllArgumentsOnNextLine: false, PenaltyBreakAssignment: 50, PointerAlignment: Left, ReferenceAlignment: Left}"']
            \}

let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style="{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true, FixNamespaceComments: false, NamespaceIndentation: All, AlignConsecutiveAssignments: true, AlignEscapedNewlines: true, AlignOperands: Align, AlignTrailingComments: true, AllowAllParametersOfDeclarationOnNextLine: false, AllowAllArgumentsOnNextLine: false, PenaltyBreakAssignment: 50, PointerAlignment: Left, ReferenceAlignment: Left}"']
            \}

let g:neoformat_glsl_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style="{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true, FixNamespaceComments: false, NamespaceIndentation: All, AlignConsecutiveAssignments: true, AlignEscapedNewlines: true, AlignOperands: Align, AlignTrailingComments: true, AllowAllParametersOfDeclarationOnNextLine: false, AllowAllArgumentsOnNextLine: false, PenaltyBreakAssignment: 50, PointerAlignment: Left, ReferenceAlignment: Left}"']
            \}

let g:neoformat_arduino_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['--style="{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true }"']
            \}

let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_glsl = ['clangformat']
let g:neoformat_enabled_arduino = ['clangformat']
let g:neoformat_enabled_python = ['black', 'yapf']

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Run on save
augroup fmt
    autocmd!
    au BufWritePre * try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
augroup END


" -------------------------------- LSP ---------------------------------------

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
" set shortmess+=c
" require('lspconfig').clangd.setup({
"    filetypes = {"c", "cpp", "arduino", "ino"}
"})

lua << EOF

require('lspconfig').ccls.setup({
    filetypes = {"c", "cpp", "arduino", "ino"}
})


require('rust-tools').setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },

   mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'vsnip' },
    { name = 'nvim_lsp_signature_help' }
  },
})
EOF

" Code navigation shortcuts
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gs    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

augroup lspFormat
    autocmd!
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
augroup end

" -------------------------------- Highlighting -------------------------------

lua << EOF
local function ts_disable(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 5000
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    disable = function(lang, bufnr)
        return lang == "cmake" or lang == "latex" or ts_disable(lang, bufnr)
    end,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" -------------------------------- Vimtex -------------------------------

augroup latexSpell
    autocmd!
    autocmd FileType tex setlocal spell spelllang=en_gb
    autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_gb
augroup END

let g:vimtex_view_method = 'zathura'

let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \]

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'latexbuild',
    \}

" Termdebug
let g:termdebugger = "arm-none-eabi-gdb"
let g:termdebug_popup = 0
let g:termdebug_wide = 163
