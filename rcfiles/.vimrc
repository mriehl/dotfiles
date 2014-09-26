syntax on
set expandtab
set tabstop=4

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

" Nerdtree
nnoremap <C-k> :NERDTree<CR>

" Keybindings
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-h> <Esc>:tabprevious<CR>i
inoremap <C-l> <Esc>:tabnext<CR>i
inoremap <C-t> <Esc>:tabnew<CR>

nnoremap <A-Up> :wincmd k<CR>
nnoremap <A-Down> :wincmd j<CR>
nnoremap <A-Left>  :wincmd h<CR>
nnoremap <A-Right>  :wincmd l<CR>
