set nocompatible
filetype plugin indent on

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'jacoborus/tender.vim'
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'

Plug 'simrat39/rust-tools.nvim'

Plug 'simrat39/rust-tools.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'tikhomirov/vim-glsl'

call plug#end()

" Color theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable

" au colorscheme * hi Normal ctermbg=None

colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight clear ColorColumn
highlight clear SignColumn
highlight VertSplit ctermbg=NONE ctermfg=NONE


" Remove vertical line for splits
set fillchars+=vert:\ ,


" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
let g:netrw_altv=1



" General
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
set laststatus=2
set ignorecase
set smartcase
set incsearch
set hlsearch
set foldmethod=indent
set nofoldenable
set t_Co=256




" Terminal
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

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Mapping for macOS (this is Alt-t)
nnoremap † :call TermToggle(12)<CR>
inoremap † <Esc>:call TermToggle(12)<CR>
tnoremap † <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>


" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Double space removes highlight
nnoremap <Leader><space> :noh<CR>


" CtrlP
" Just use git as command, is quicker for larger projects and makes it
" possible to automatically ignore files we're not interested in
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" Formatting
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

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" LSP

lua << EOF
require'lspconfig'.ccls.setup{}
EOF

" Avoid showing extra messages when using completion
set shortmess+=c

lua << EOF
local lspconfig = require'lspconfig'

lspconfig.ccls.setup {
    filetypes = {"c", "cpp", "arduino", "ino"}
}
EOF


lua << EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
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
}

require('rust-tools').setup(opts)
EOF


lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_prev_item(),
    ['<C-h>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
