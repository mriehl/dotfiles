syntax on
set nolist
set expandtab
set tabstop=4
set switchbuf=usetab,newtab
set backspace=indent,eol,start

let mapleader=","

au FileType gitcommit set tw=72

au FileType python setlocal formatprg=autopep8\ -

filetype plugin indent on

execute pathogen#infect()

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

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

let g:NERDTreeIgnore = ['\v\.(exe|so|dll|pyc|pyo|a)$']

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
