"General Leader shortcuts {{{1
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','
" source: http://amix.dk/vim/vimrc.html

" Package management (vundle) and plugins {{{1

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'groenewege/vim-less'
Plugin 'ap/vim-css-color'
Plugin 'valloric/youcompleteme'
Plugin 'jiangmiao/auto-pairs'
Plugin 'yggdroot/indentline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'crusoexia/vim-monokai'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" General settings {{{1

set autoindent " Copy indent from last line when starting new line
set background=dark
set cursorline " Highlight current line
set encoding=utf-8 nobomb " BOM often causes trouble
set expandtab " Expand tabs to spaces
set foldcolumn=0 " Column to show folds
set nofoldenable " No folding by default
set foldlevel=0 " Close all folds by default
set foldmethod=syntax " Syntax are used to specify folds
set foldminlines=0 " Allow folding single lines
set foldnestmax=5 " Set max fold nesting level
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set hidden " When a buffer is brought to foreground, remember undo history and marks
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set mouse=a " Enable mouse in all in all modes
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set nu " Enable line numbers
set ruler " Show the cursor position
set shiftwidth=2 " The # of spaces for indenting
set shortmess=atI " Don't show the intro message when starting vim
set showtabline=2 " Always show tab bar
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2 " Tab key results in 2 space
set title " Show the filename in the window titlebar
set ttymouse=xterm " Set mouse type to xterm
set visualbell " Use visual bell instead of audible bell (annnnnoying)

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" source: http://amix.dk/vim/vimrc.html

nnoremap <leader>bs :CtrlPBuffer<CR>
map <Leader>, <C-^>
map <Leader>ls :buffers<CR>
map gb :bnext<CR>
map gB :bprev<CR>

syntax on
colorscheme monokai 

" vim-airline {{{1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
" }}}


" NERD-Tree {{{1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists('b:NERDTreeType') &&b:NERDTreeType == 'primary') | q | endif
let NERDTreeShowHidden=1
map <Leader>s :NERDTreeToggle<CR>
" }}}

" indentLine  {{{
let g:indentLine_color_dark = 1
let g:indentLine_char = '┆'
" }}}
