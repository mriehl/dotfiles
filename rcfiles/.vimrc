syntax on
set nolist
set expandtab
set tabstop=4
se switchbuf=usetab,newtab

let mapleader=","

au FileType gitcommit set tw=72
filetype plugin indent on

execute pathogen#infect()

" Jedi plugin
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

" Ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](target|venv|ve|ve2|ve3|__pycache__)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo|a)$',
  \ }

" Nerdtree
nnoremap <C-k> :NERDTree<CR>

" Keybindings
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-h> <Esc>:tabprevious<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

" Environment
let $RUST_SRC_PATH="/opt/rust-src/src"
