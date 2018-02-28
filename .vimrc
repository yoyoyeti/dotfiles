set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Install vim-plug if it's not there
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

  Plug 'junegunn/fzf' "fuzzy file search
  Plug 'junegunn/fzf.vim' "fuzzy file search
  Plug 'christoomey/vim-tmux-navigator' "makes using ctrl + h/j/k/l navigate vim and tmux panes
  Plug 'chemzqm/vim-jsx-improve' "jsx syntax highlighting
  Plug 'vim-airline/vim-airline' "shows fancy bars with info at top and bottom
  Plug 'tpope/vim-fugitive' "shows the git information in the fancy bars
  Plug 'Raimondi/delimitMate' "autocomplete in insert mode for quotes and things
  Plug 'arcticicestudio/nord-vim' "theme
  Plug 'chrisbra/Colorizer' "highlights colors
  Plug 'airblade/vim-gitgutter' "shows git diff information
  Plug 'ntpeters/vim-better-whitespace' "shows trailing whitespace
  Plug 'scrooloose/nerdcommenter' "commenting shortcuts
  Plug 'scrooloose/nerdtree' "nerdtree file explored
  Plug 'machakann/vim-highlightedyank' "highlights the text
  Plug 'easymotion/vim-easymotion' "makes moving around easier
  Plug 'haya14busa/incsearch.vim' "makes searching better in general and allows the use of tab and shift + tab to navigate while searching
  Plug 'haya14busa/incsearch-easymotion.vim' "search that implements easymotion
  Plug 'haya14busa/incsearch-fuzzy.vim' "makes searching fuzzy
  Plug 'AndrewRadev/sideways.vim' "makes moving parameters around ezpz
  Plug 'ervandew/supertab' "tab completion
  Plug 'wellle/targets.vim' "more things to target
  Plug 'tpope/vim-surround' "makes wrapping things in stuff easier
  Plug 'tpope/vim-repeat' "makes things repeat with .
  Plug 'jreybert/vimagit' "adds commit functionality to vim wit <leader>M
  Plug 'w0rp/ale' "linting stuff
  Plug 'aquach/vim-http-client' "http client thing
  Plug 'elzr/vim-json' "better json highlighting and syntax stuff
  Plug 'ryanoasis/vim-devicons' "adds icons to nerdtree
  Plug 'idanarye/vim-merginal' "git branch toob
  Plug 'devnul1/heman'
  Plug 'devnul1/vim-airline-themes'

call plug#end()

"makes vim not use terminal colors and relies on its own colorscheme
set termguicolors

"makes leader + H open my requests file if I'm not there, and send the request if I am
nnoremap <expr><nowait><silent> <leader>h (expand('%:t') ==? ".http_requests.py" ? ":HTTPClientDoRequest<CR>" : ":e ~/workspace/.http_requests.py<CR>")
"makes leader + c clear the http response window if that's the focused buffer
nnoremap <silent><expr><nowait> <leader>c (expand('%:t') ==? "__HTTP_Client_Response__" ? "ggVGd" : "")
"closes the http response buffer with 'q' if that's the focused buffer
nnoremap <silent><expr><nowait> q (expand('%:t') ==? "__HTTP_Client_Response__" ? ":q<CR>" : "")

"makes http client responses formated in json instead of js
let g:http_client_json_ft = 'json'
"keeps previous responses
let g:http_client_preserve_responses = 1

"makes ale only use eslint to find linting errors
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

"fixes tmux navigating in neovim
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

"makes magit open file and hunk folds by default
let g:magit_default_fold_level=2
"automagically updates gitgutter stuff
autocmd User VimagitUpdateFile
  \ if ( exists("*gitgutter#process_buffer") ) |
  \ 	call gitgutter#process_buffer(bufnr(g:magit_last_updated_buffer), 0) |
  \ endif

"makes 'h' open nerdtree nodes
let NERDTreeMapActivateNode='h'

"makes nerdtree more pretty
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"makes it so nerdtree won't ask you if you want to delete the buffer of the
"file you just deleted
let NERDTreeAutoDeleteBuffer = 1

"makes moving lines or blocks up or down really easy with arrow keys
nnoremap <silent><down> :m .+1<CR>==
nnoremap <silent><up> :m .-2<CR>==
vnoremap <silent><down> :m '>+1<CR>gv=gv
vnoremap <silent><up> :m '<-2<CR>gv=gv

"mades terms with dashes single term instead of multiple terms
set iskeyword+=\-

"makes it so you can move parameters around with arrow keys
nnoremap <silent><left> :SidewaysLeft<cr>
nnoremap <silent><right> :SidewaysRight<cr>

"better easymotion keys
map <Space>h <Plug>(easymotion-b)
map <Space>j <Plug>(easymotion-j)
map <Space>k <Plug>(easymotion-k)
map <Space>l <Plug>(easymotion-w)

"makes smartcase work with easymotion
let g:EasyMotion_smartcase = 1

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

"makes double tapping r refresh nvim init
nnoremap <silent>rr :source ~/.config/nvim/init.vim<CR>
" binds control-e to edit nvim init
nnoremap <silent><c-e> :e ~/.config/nvim/init.vim<CR>

"makes these binds use incsearch instead of normal search
map / <Plug>(incsearch-forward)
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

"makes nerdtree close if it's the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"makes yanking into * register (clipboard) easier also highlights yanked stuff
map <c-y> "*<Plug>(highlightedyank)

"makes pasting from * register (clipboard) easier
map <c-p> "*p

"makes yanked text highlighted
map y <Plug>(highlightedyank)

"makes pressing Y yank to the end of the line rather than the whole line
map Y <Plug>(highlightedyank)$

"makes control-n toggle nerdtree
map <silent><C-n> :NERDTreeToggle<CR>

"makes control-c toggle comment things
map // <leader>c<space>

"strips whitespace with ctrl-s
noremap <silent><C-s> :StripWhitespace<CR>

"theme
colorscheme heman
"makes selected item in dropdown a diffrent color than the dropdown itself
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#dadada guibg=#638ffa

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
nnoremap <silent><C-X> :bp<bar>sp<bar>bn<bar>bd<CR>

" statusline style
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
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
nnoremap <silent><space>b :bprevious<CR>
nnoremap <silent><space>n :bnext<CR>

" toggle last two last buffers with space u
nnoremap <space>u <c-^>

"switching vim panes with ctrl + h/j/k/l
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"binds ctrl f to fuzzy search for files that are tracked by git
nnoremap <silent><leader>, :Colors<CR>
nnoremap <silent><C-F> :GFiles<CR>
nnoremap <silent><C-G> :GFiles?<CR>

"more natural splits
set splitbelow
set splitright

"makes colors autohighlight for html and css files
let g:colorizer_auto_filetype='css,html'

"makes braces not get highlighted
let g:loaded_matchparen = 1

"makes buffers hide instead of close when switching
set hidden

"prevents lines frow wrapping
set nowrap

"makes searching for text ignore case when no capital leters are present and
"case sensitive when they are
set ignorecase
set smartcase

"automatically un-highlights when you do anything
let g:incsearch#auto_nohlsearch = 1

"automatic titles
set title
"no more audio errors
set visualbell
set noerrorbells

"removes esc delay
set timeoutlen=1000 ttimeoutlen=0

"clears last search
"let @/ = ''
