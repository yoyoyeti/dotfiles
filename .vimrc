set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'junegunn/fzf' "fuzzy file search
Plugin 'christoomey/vim-tmux-navigator' "makes using ctrl + h/j/k/l navigate vim and tmux panes
Plugin 'pangloss/vim-javascript' "javascript syntax stuff
Plugin 'mxw/vim-jsx' "jsx syntax stuff
Plugin 'vim-airline/vim-airline' "shows fancy bars with info at top and bottom
Plugin 'tpope/vim-fugitive' "shows the git information in the fancy bars
Plugin 'haya14busa/incsearch.vim' "makes searching better in general and allows the use of tab and shift + tab to navigate while searching
Plugin 'Raimondi/delimitMate' "autocomplete in insert mode for quotes and things
Plugin 'arcticicestudio/nord-vim' "theme
Plugin 'chrisbra/Colorizer' "highlights colors
Plugin 'airblade/vim-gitgutter' "shows git diff information
Plugin 'ntpeters/vim-better-whitespace' "shows trailing whitespace
Plugin 'scrooloose/nerdcommenter' "commenting shortcuts
Plugin 'scrooloose/nerdtree' "nerdtree file explored
" All of your Plugins must be added before the following line
call vundle#end()

"indenting stuff
filetype plugin indent on

"shows line numbers
set number
"shows syntax highlighting
syntax on

set noshowmode
set noruler
set laststatus=0
set noshowcmd

"makes nerdtree close if it's the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"makes control-n toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

map <C-c> <plug>NERDCommenterToggle
"shows extra space

"theme
colorscheme nord

"changes search color
hi Search cterm=NONE ctermfg=cyan ctermbg=red

"makes vim update more often
set updatetime=250

"makes gitgutter not may any keys
let g:gitgutter_map_keys = 0

"unbinds arrowkeys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"rempas capital J and K to jump paragraphs
nnoremap <S-J> }
nnoremap <S-K> {
"remaps { and } to join with line before and join with line after
nnoremap } <S-J>
nnoremap { -J
"same thing but for visual mode as well
vnoremap <S-J> }
vnoremap <S-K> {
vnoremap } <S-J>
vnoremap { -J

"makes delimitMate match < with > as well as the defaults
let delimitMate_matchpairs = "(:),[:],{:},<:>"

set complete=.,b,u,w,t,]

"inserts new line behind without entering insert mode
nnoremap < O<Esc>j
"inserts new line after without entering insert mode
nnoremap > o<Esc>k
"inserts new line where cursor is without entering insert mode
nnoremap <CR> i<CR><Esc><BS>

"makes one line appear above and below cursor at all times
set scrolloff=1

"makes { and } skip folds
set foldopen-=block
"makes folds work but not automatically fold on open
set foldmethod=indent
"prevents auto folding
set foldlevelstart=99

"binds ctrl-x to close buffer without closing window
nnoremap <C-X> :bp<bar>sp<bar>bn<bar>bd<CR>

" statusline style
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"fixing backspace
set backspace=2
set backspace=indent,eol,start

"fixing tabs
set tabstop=2
set shiftwidth=2
set shiftround
set autoindent
set copyindent
set smarttab
set smartindent

" switch between buffers with space h for prev and space l for next
nnoremap <silent> <space>h :bprevious<CR>
nnoremap <silent> <space>l :bnext<CR>
" toggle last two buffers with space u
nnoremap <space>u <c-^>

"switching vim panes with ctrl + h/j/k/l
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"binds ctrl f to fuzzy search
nnoremap <C-F> :FZF<CR>

"more natural splits
set splitbelow
set splitright

"makes colors autohighlight for html and css files
let g:colorizer_auto_filetype='css,html'

"colors
set t_Co=256

"makes braces not get highlighted
let g:loaded_matchparen= 1

"makes buffers hide instead of close when switching
set hidden

"prevents lines frow wrapping
set nowrap

"makes searching for text ignore case when no capital leters aren't present and
"case sensitive when they are
set ignorecase
set smartcase

"makes these binds use incsearch instead of normal search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"highlights all found search terms
set hlsearch
"automatically un-highlights when you do anything
let g:incsearch#auto_nohlsearch = 1

"automatic titles
set title
"no more audio errors
set visualbell
set noerrorbells

"removes esc delay
set timeoutlen=1000 ttimeoutlen=0
