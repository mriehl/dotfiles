syntax on
set expandtab
set tabstop=4

au FileType gitcommit set tw=72
filetype plugin indent on

execute pathogen#infect()
