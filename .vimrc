set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()

filetype plugin indent on

set number
syntax on

" statusline style
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"fixing backspace
set backspace=2
set backspace=indent,eol,start

"fixing tabs
set tabstop=2
set shiftwidth=2

" switch between buffers
nnoremap <silent> <space>h :bprevious<CR>
nnoremap <silent> <space>l :bnext<CR>
" toggle last two buffers
nnoremap <space>u <c-^>

"switching vim panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"more natural splits
set splitbelow
set splitright

"colors
set t_Co=256

"makes buffers hide instead of close when switching
set hidden

""lots of stuff
set nowrap
set tabstop=2
set autoindent
set copyindent
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set smartindent
set hlsearch
set incsearch
set title
set visualbell
set noerrorbells
set expandtab

func! s:matchparen_cursorcolumn_setup()
  augroup matchparen_cursorcolumn
    autocmd!
    autocmd CursorMoved * if get(w:, "paren_hl_on", 0) | set cursorcolumn | else | set nocursorcolumn | endif
    autocmd InsertEnter * set nocursorcolumn
  augroup END
endf
if !&cursorcolumn
  augroup matchparen_cursorcolumn_setup
    autocmd!
    autocmd CursorMoved * if exists("#matchparen#CursorMoved") | call <sid>matchparen_cursorcolumn_setup() | endif
          \ | autocmd! matchparen_cursorcolumn_setup
  augroup END
endif
