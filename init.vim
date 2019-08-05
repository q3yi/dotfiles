
set encoding=utf-8

set number
set relativenumber

set tabstop=4
set shiftwidth=4
set softtabstop=4
set scrolloff=5
"set foldmethod=syntax

" no need to show mode as lightline show status already
set noshowmode

let mapleader=" "

map <LEADER>s :w<CR>
map <LEADER>q :q<CR>
map <LEADER><CR> :nohlsearch<CR>

map <LEADER>rc :exec "source $MYVIMRC"<CR>
map <LEADER>ec :exec "edit $MYVIMRC"<CR>

map <LEADER>p "+p
map <LEADER>y "+y

map <LEADER>ww <C-w>w
map <LEADER>wn <C-w>l
map <LEADER>wh <C-w>h
map <LEADER>wt <C-w>j
map <LEADER>wc <C-w>k

map <F2> :NERDTreeToggle<CR>

"'Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" UI plugins
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Add coc compelete system
" deoplet/ncm2/coc.nvim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git
" vim gitgutter
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

Plug 'jiangmiao/auto-pairs'
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
set termguicolors 
colorscheme gruvbox
let g:lightline = { 'colorscheme': 'jellybeans' }

noremap t <nop>
noremap n l
noremap t j
noremap c k
noremap j c
