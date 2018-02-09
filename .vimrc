set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' "let Vundle manage Vundle, required

Plugin 'junegunn/fzf' "fuzzy file search
Plugin 'junegunn/fzf.vim' "fuzzy file search
Plugin 'christoomey/vim-tmux-navigator' "makes using ctrl + h/j/k/l navigate vim and tmux panes
Plugin 'chemzqm/vim-jsx-improve' "jsx syntax highlighting
Plugin 'vim-airline/vim-airline' "shows fancy bars with info at top and bottom
Plugin 'tpope/vim-fugitive' "shows the git information in the fancy bars
Plugin 'Raimondi/delimitMate' "autocomplete in insert mode for quotes and things
Plugin 'arcticicestudio/nord-vim' "theme
Plugin 'chrisbra/Colorizer' "highlights colors
Plugin 'airblade/vim-gitgutter' "shows git diff information
Plugin 'ntpeters/vim-better-whitespace' "shows trailing whitespace
Plugin 'scrooloose/nerdcommenter' "commenting shortcuts
Plugin 'scrooloose/nerdtree' "nerdtree file explored
Plugin 'vim-syntastic/syntastic' "syntax highligting stuff
Plugin 'machakann/vim-highlightedyank' "highlights the text
Plugin 'easymotion/vim-easymotion' "makes moving around easier
Plugin 'haya14busa/incsearch.vim' "makes searching better in general and allows the use of tab and shift + tab to navigate while searching
Plugin 'haya14busa/incsearch-easymotion.vim' "search that implements easymotion
Plugin 'haya14busa/incsearch-fuzzy.vim' "makes searching fuzzy
Plugin 'AndrewRadev/sideways.vim' "makes moving parameters around ezpz
Plugin 'ervandew/supertab' "tab completion
Plugin 'wellle/targets.vim' "more things to target
Plugin 'tpope/vim-surround' "makes wrapping things in stuff easier
Plugin 'tpope/vim-repeat' "makes things repeat with .

"All of your Plugins must be added before the following line
call vundle#end()

"makes moving lines or blocks up or down really easy with arrow keys
nnoremap <down> :m .+1<CR>==
nnoremap <up> :m .-2<CR>==
vnoremap <down> :m '>+1<CR>gv=gv
vnoremap <up> :m '<-2<CR>gv=gv

"mades terms with dashes single term instead of multiple terms
set iskeyword+=\-

"makes it so you can move parameters around with arrow keys
nnoremap <left> :SidewaysLeft<cr>
nnoremap <right> :SidewaysRight<cr>

"better easymotion keys
map <Space>h <Plug>(easymotion-linebackward)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
map <Space>l <Plug>(easymotion-lineforward)
map <Space>s <Plug>(easymotion-s)

"makes accidently typing :W not so bad
map :W :w

"incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \   'converters': [incsearch#config#fuzzy#converter()],
        \   'modules': [incsearch#config#easymotion#module()],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction

"makes space + / do a fuzzy easymotion search
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

"performs a non fuzzy easymotion search
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)

"makes double tapping r refresh .vimrc
nnoremap rr :source ~/.vimrc<CR>

"makes these binds use incsearch instead of normal search
"map /  <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map # <Plug>(incsearch-nohl-*)
map * <Plug>(incsearch-nohl-#)

"indenting stuff
filetype plugin indent on

"shows line numbers
set number
"shows syntax highlighting
syntax on

"Hides ugly stuff on the bottom
set noshowmode
set noruler
set laststatus=0
set noshowcmd

"makes nerdtree close if it's the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"makes syntastic use pylint
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_always_populate_loc_list = 1

let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": [],
      \ "passive_filetypes": [] }

"makes yanking into * register (clipboard) easier also highlights yanked stuff
map <c-y> "*<Plug>(highlightedyank)

"makes pasting from * register (clipboard) easier
map <c-p> "*p

"makes yanked text highlighted
map y <Plug>(highlightedyank)

"makes pressing Y yank to the end of the line rather than the whole line
map Y <Plug>(highlightedyank)$

"makes control-n toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

"makes control-c toggle comment things
map // <leader>c<space>

"strips whitespace with ctrl-s
noremap <C-s> :StripWhitespace<CR>

"theme
colorscheme nord

"changes search color
hi Search cterm=NONE ctermfg=cyan ctermbg=red

"makes vim update more often
set updatetime=250

"makes gitgutter not may any keys
let g:gitgutter_map_keys = 0

"rempas capital J and K to jump paragraphs
nnoremap J }
nnoremap K {
"remaps { and } to join with line before and join with line after
nnoremap } J
nnoremap { -J
"same thing but for visual mode as well
vnoremap J }
vnoremap K {
vnoremap } J
vnoremap { -J

"makes delimitMate match < with > as well as the defaults
let delimitMate_matchpairs = "(:),[:],{:},<:>"

"makes autocomplete do fancy stuff
set complete=.,b,u,w,t,]

"only required one > or < to make adjust indent
nnoremap < <<
nnoremap > >>

"makes pressing H/L insert a new line above/below cursor without entering insert mode
"or moving the cursor
map H O<Esc>j
map L o<Esc>k

"inserts new line where cursor is without entering insert mode
nnoremap <CR> i<CR><Esc><BS>

"makes one line appear above and below cursor at all times
set scrolloff=1

"makes tab completion in vim console insanely better
set wildmode=longest,list

"makes J and K skip folds
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
set expandtab
set shiftround
set autoindent
set copyindent
set smarttab
set smartindent

" switch between buffers with space b for prev and space n for next
nnoremap <silent> <space>b :bprevious<CR>
nnoremap <silent> <space>n :bnext<CR>
" toggle last two last buffers with space u
nnoremap <space>u <c-^>

"switching vim panes with ctrl + h/j/k/l
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"binds ctrl f to fuzzy search
nnoremap <C-F> :GFiles<CR>

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

"makes searching for text ignore case when no capital leters are present and
"case sensitive when they are
set ignorecase
set smartcase

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
