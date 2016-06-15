set nocompatible
set autoindent
set ruler
set number
set showcmd

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'valloric/youcompleteme'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'crusoexia/vim-monokai'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
call vundle#end()
filetype plugin indent on

autocmd vimenter * NERDTree

syntax enable
colorscheme monokai 

