syntax on
set expandtab
set tabstop=4

let mapleader=","

au FileType gitcommit set tw=72
filetype plugin indent on

execute pathogen#infect()
