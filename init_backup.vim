set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=10
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix


call plug#begin('~/.vim/plugged')

Plug 'projekt0n/github-nvim-theme'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'lervag/vimtex'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'

call plug#end()

let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('omni', 'input_patterns', {'tex': g:vimtex#re#deoplete})

colorscheme github_dark