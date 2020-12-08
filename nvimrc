" Leader
let mapleader = "s"
nnoremap <leader>d dd

" Allow async
let g:has_async = 1
" auto-install vim-plug

" Plugins
call plug#begin('~/dotfiles/nvim/plugins')
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'adelarsq/vim-matchit'
Plug 'junegunn/gv.vim'
Plug 'leshill/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'rust-lang/rust.vim'
Plug 'chr4/nginx.vim'
Plug 'ctiml/haproxy-syntax-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }
call plug#end()

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Turn on detection, plugin, and indent configurations
filetype plugin indent on
syntax on

set backspace=2		" Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler		" shows cursor position all the time
set showcmd " display incomplete commands
set autowrite " Automatically :write before running commands

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespaces
set list listchars=tab:»·,trail:·,nbsp:·

" Use 1 space after punctuation
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=150
set colorcolumn=+1

" === Numbers ===
"
" Shows line numbers and also shows relative numbers, such that each line number
" can be accessed using 'j' and 'k' instead of typing the number and using 'gg' to jump to it
set number relativenumber
set numberwidth=5

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" === Numbers ===
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-p>"
  endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Cursor
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Color scheme
let g:solarized_termcolors = 16
let g:solarized_contrast = "high"
set bg=dark

" Ctrl-P configuration
let g:ctrlp_custom_ignore = 'node_modules\|DS_STORE\|git\|vendor\|public\|tmp\|spec/fixtures'

" Use The Silver Searcher over native grep if it exists
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " use ag in CtrlP for listing files. Respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  " ag is so fast we dont need a cache
  let g:ctrlp_use_caching = 0
endif

let g:ale_fix_on_save = 1

" Quickly jump between linting errors with [c and ]c
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

" Change default ale error and warning signs
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Go
" run go imports along gofmt on each save
let g:go_fmt_command = "goimports"
" Automatically get sdignature/type info for object under cursor
let g:go_auto_type_info = 1


lua << EOF
require'nvim_lsp'.elixirls.setup{}
EOF

" === BEGIN RUST SETUP ===
" setup rust_analyzer LSP (IDE features)
"
" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

EOF

" === END REST SETUP ===

" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

set nowrap
set sidescroll=15
set listchars+=precedes:<,extends:> "Shows '<' to represent hidden text when horizontally scrolling through a long line'"
