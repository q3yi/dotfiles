" nvim config aim to work well both on mac and windows

set encoding=utf-8
set fileencoding=utf8 fileencodings=utf8,gb2312,big5
set fileformat=unix fileformats=unix,dos,mac

set number
" set relativenumber

set mouse=a

syntax enable

set tabstop=4
set shiftwidth=4
set softtabstop=4

set scrolloff=5
"set foldmethod=syntax

" no need to show mode as lightline/airline show status already
set noshowmode

" allow change to other buffer without save current buffer
set hidden

" Search down into sub-folders
" :find, :sfind, :tabfind
set path+=**

"" Completion in CMD line
" Display match on status line
set wildmenu
set wildmode=full
set wildignore=*.swp,*.bak,*.pyc,*.pyo,*.class

set smartcase

" Install plugin
call plug#begin('~/.config/nvim/plugged')

" UI plugins
Plug 'morhetz/gruvbox'

" lightline not work well on window
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'itchyny/lightline.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Add coc compelete system
" deoplet/ncm2/coc.nvim
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'Shougo/neosnippet.vim'
Plug 'ncm2/ncm2-neosnippet'
Plug 'ncm2/ncm2-go'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" git
" vim gitgutter
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'kassio/neoterm'

Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'tag': '*' }

" editorconfig-vim
" emmet
" ale

call plug#end()

" set colors
if has('vcon')
    set termguicolors
endif

colorscheme gruvbox
"let g:airline_theme='wombat'

" don't give |ins-completion-menu| messages.
set shortmess+=c

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_neosnippet#expand_or("\<CR>", 'n')

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let mapleader=" "

map <LEADER>s :w<CR>
map <LEADER>q :q<CR>

" Shortcut to edit config
map <LEADER>rc :exec 'source '.stdpath('config').'/init.vim'<CR>
map <LEADER>ec :exec 'edit '.stdpath('config').'/init.vim'<CR>

map <LEADER>p "+p
" only work in visual mode
vnoremap <LEADER>y "+y

" jump to next quixfix error in location list
nmap <LEADER>f :lnext<Enter>
nmap <LEADER>F :lprevious<Enter>

map <LEADER>t :NERDTreeToggle<CR>

map <LEADER>m :only<CR>

map <C-w>n <C-w>l
map <C-w>t <C-w>j
map <C-w>c <C-w>k

" meta key in mac need setting in console config
noremap <M-n> l
noremap <M-t> j
noremap <M-c> k
noremap <M-h> h

noremap <silent> <M-g> :bprev<CR>
noremap <silent> <M-r> :bnext<CR>

" move to prev buffer and delete current buffer
noremap <silent> <M-d> :bp\|bd #<CR>

" clear hlsearch when clear screen
noremap <C-l> :<C-u>nohlsearch<CR><C-l>

" jump to line end in insert mode
inoremap <C-e> <C-o>A

" Emacs keybinding for command line mode editing
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
