syntax on
set nolist
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set switchbuf=usetab,newtab
set backspace=indent,eol,start
set mouse-=a

let mapleader=","

au FileType gitcommit set tw=72

filetype plugin indent on

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'fatih/vim-go'
Plug 'jonathanfilip/vim-lucius'
Plug 'derekwyatt/vim-scala'
Plug 'wting/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'Valloric/YouCompleteMe'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme lucius
LuciusLight

" Execute cmdpalette commands instead of just completing them
let g:ctrlp_cmdpalette_execute = 1

" Ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](target|venv|ve|ve2|ve3|__pycache__)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo|a)$',
  \ }

let g:NERDTreeIgnore = ['\v\.(exe|so|dll|pyc|pyo|a|class)$']

" Nerdtree
nnoremap <C-k> :NERDTree<CR>

" CtrlP CmdPalette
nnoremap <C-j> :CtrlPCmdPalette<CR>

" Keybindings
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-h> <Esc>:tabprevious<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

command KillTrailing :%s/\s\+$//e

" Racer
let g:racer_experimental_completer = 1
let g:racer_cmd = "/usr/local/bin/racer"

" Airline all the time
set laststatus=2

" Environment
let $RUST_SRC_PATH="/opt/rust-src/src"

set listchars=eol:¶,tab:»·,trail:·,extends:»,precedes:«

set omnifunc=syntaxcomplete#Complete

if !exists('g:airline_symbols')
 let g:airline_symbols = {}
endif

if !has("win32")
 " unicode symbols
 let g:airline_left_sep = '▶'
 let g:airline_right_sep = '◀'
 let g:airline_symbols.branch = '⎇'
endif
