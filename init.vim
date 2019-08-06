" Vim config aim to work well both on mac and windows

set nocompatible
set encoding=utf-8

set number
set relativenumber

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

syntax enable

set tabstop=4
set shiftwidth=4
set softtabstop=4

set scrolloff=5
"set foldmethod=syntax

" no need to show mode as lightline/airline show status already
set noshowmode
set laststatus=2

" Search down into sub-folders
" :find, :sfind, :tabfind
set path+=**

"" Completion in CMD line
" Display match on status line
set wildmenu
set wildmode=full
set wildignore=*.swp,*.bak,*.pyc,*.pyo,*.class

" Install plugin
call plug#begin('~/.config/vim/plugged')

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
" coc.vim need another lps for autocomplete instead of using vim-go plug
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

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

" Setup deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" set colors
if has('vcon')
    set termguicolors
endif

" colorscheme gruvbox
let g:airline_theme='wombat'

let mapleader=" "

map <LEADER>s :w<CR>
map <LEADER>q :q<CR>
map <LEADER><CR> :nohlsearch<CR>

" Shortcut to edit config
" TODO not work on windows
map <LEADER>rc :exec "source $MYVIMRC"<CR>
map <LEADER>ec :exec "edit $MYVIMRC"<CR>

map <LEADER>p "+p
map <LEADER>y "+y

map <F2> :NERDTreeToggle<CR>

map <C-w>n <C-w>l
map <C-w>t <C-w>j
map <C-w>c <C-w>k

noremap s <nop>
noremap n l
noremap t j
noremap c k
noremap k c
noremap j t
noremap l n

inoremap <C-m> <C-o>A
