set nocompatible
filetype plugin indent on

" -------------------------------- Plugins ------------------------------------
call plug#begin('~/.vim/plugged')

" Tree
Plug 'nvim-tree/nvim-tree.lua'

" Syntax highlightning
Plug 'nvim-treesitter/nvim-treesitter'

" Formatting and LSP
Plug 'sbdchd/neoformat'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'

" Completion engine
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'rstacruz/vim-closer'

" Language specifics
Plug 'simrat39/rust-tools.nvim'
Plug 'tikhomirov/vim-glsl'
Plug 'lervag/vimtex'

" Wiki support
Plug 'vimwiki/vimwiki'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Theme
Plug 'nvim-tree/nvim-web-devicons'
Plug 'EdenEast/nightfox.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'itchyny/lightline.vim'


" DiffView for Git
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'

" Start screen
Plug 'goolord/alpha-nvim'

Plug 'numToStr/Comment.nvim'

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

call plug#end()

packadd termdebug

let s:uname = system("uname")


" -------------------------------- Theme ----------------------------------------

syntax enable
set termguicolors
set cursorline

colorscheme nordfox

let g:lightline = {
    \ 'colorscheme': 'nordfox',
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
set clipboard=unnamedplus

" Set fold to indent and not to automatically fold
set foldmethod=indent
set nofoldenable

set laststatus=3

" Hide the current command
set noshowcmd


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

" -------------------------------- NvimTree -----------------------------------
nnoremap <leader>n :NvimTreeFocus<CR>
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

lua << EOF
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    require("nvim-tree").setup {
        view = {
            adaptive_size = true,
            hide_root_folder = true,
        },
    }
EOF

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

nnoremap <Leader>tt :call TermToggle(12)<CR>
inoremap <Leader>tt <Esc>:call TermToggle(12)<CR>
tnoremap <Leader>tt <C-\><C-n>:call TermToggle(12)<CR>

" -------------------------------- Fuzzy finder ---------------------------------

if s:uname == "Darwin\n"
    let g:fzf_tags_command = '/opt/homebrew/opt/ctags/bin/ctags -R --exclude=.git --exclude=.ccls-cache'
else
    let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=.ccls-cache'
endif

autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

nnoremap <C-p> :Files<CR>
nnoremap <C-u> :BTags<CR>
nnoremap <Leader>fg :Rg<CR>
nnoremap <Leader>fh :History:<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Bat theme for preview
let $BAT_THEME='base16-256'

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
            \ 'args': ['--style="{ IndentWidth: 4, AllowShortLoopsOnASingleLine: true, AllowShortBlocksOnASingleLine: true, ColumnLimit: 80, BinPackParameters: false, BinPackArguments: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignConsecutiveMacros: true, FixNamespaceComments: false, NamespaceIndentation: All, AlignConsecutiveAssignments: true, AlignEscapedNewlines: true, AlignOperands: Align, AlignTrailingComments: true, AllowAllParametersOfDeclarationOnNextLine: false, AllowAllArgumentsOnNextLine: false, PenaltyBreakAssignment: 50, PointerAlignment: Left, ReferenceAlignment: Left}"']
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

lua << EOF

require('lspconfig').clangd.setup({
    filetypes = {"c", "cpp"}
})

require('lspconfig').pyright.setup{}


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

  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = true,
    disallow_prefix_unmatching = false,
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
        return lang == "cmake" or lang == "latex" or lang == "lua" or ts_disable(lang, bufnr)
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

if s:uname == "Darwin\n"
    let g:vimtex_view_method = 'skim'
    let g:vimtex_view_skim_sync = 1
    let g:vimtex_view_skim_activate = 1
else
    let g:vimtex_view_method = 'zathura'
endif

let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \]

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'latexbuild',
    \ 'options' : [
    \    '-shell-escape',
    \    '-verbose',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}

" Termdebug
let g:termdebugger = "arm-none-eabi-gdb"
let g:termdebug_popup = 0
let g:termdebug_wide = 163

let g:termdebug_popup = 1

hi debugPC term=reverse ctermbg=0 guibg=0

" Close the output window when launching termdebug
nnoremap <Leader>td :Termdebug %:r<CR><c-w>j <c-w>q i
nnoremap <RightMouse> :Break<CR>

" Use <Leader> w for window management, and map <Leader>w for window
" management
nnoremap <Leader>w <C-w>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ------------------------------ DiffView ---------------------------
nnoremap <Leader>dv :DiffviewOpen<CR>
nnoremap <Leader>dc :DiffviewClose<CR>
nnoremap <Leader>df :DiffviewFileHistory<CR>


" ------------------------------ Alpha ---------------------------

lua << EOF
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
        dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "f", "  > Find file", ":GFiles<CR>"),
        dashboard.button( "r", "  > Recent"   , ":History<CR>"),
        dashboard.button( "s", "  > Settings" , ":e $MYVIMRC <CR>"),
        dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
    }

    local fortune = require("alpha.fortune")
    dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
    ]])
EOF


" Clear cmd line message
function! s:empty_message(timer)
  if mode() ==# 'n'
    echon ''
  endif
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(500, funcref('s:empty_message'))
augroup END

" ------------------------------ Comment ---------------------------

lua << EOF
require('Comment').setup()
EOF
