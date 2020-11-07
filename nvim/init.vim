" my nvim config

let mapleader=','
" let maplocalleader='\'

" Plugin list starts
call plug#begin('~/.dotfiles/nvim/plugged')

" Plugins
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'whatyouhide/vim-gotham'
Plug 'gf3/molotov'
Plug 'arcticicestudio/nord-vim'
Plug 'fcpg/vim-orbital'
Plug 'https://github.com/rakr/vim-two-firewatch.git'
Plug 'jacoborus/tender.vim'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'https://github.com/cocopon/iceberg.vim.git'
Plug 'https://github.com/arzg/vim-plan9'
Plug 'https://github.com/AlessandroYorba/Alduin'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'

Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree' " nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin' " nerdtree git int 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sjl/vitality.vim' " play nice with iterm2
Plug 'christoomey/vim-tmux-navigator'

Plug 'vim-syntastic/syntastic' " find sytnax errors
Plug 'jiangmiao/auto-pairs' " auto pairs brackets
Plug 'tpope/vim-surround' " deal with surrounding in pairs
Plug 'tpope/vim-fugitive' " git commands
Plug 'airblade/vim-gitgutter' " shows git status in gutter
Plug 'Yggdroot/indentLine' " shows indent line in editor

Plug '/usr/local/opt/fzf' " hmmm what's this?
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" js on steroids
Plug 'pangloss/vim-javascript'
" js/ts stuff
Plug 'leafgarland/typescript-vim'
" plug into tsserver
Plug 'Quramy/tsuquyomi'
" Smart indenting for JS and TS
Plug 'jason0x43/vim-js-indent'

" Installs and builds vimproc (required to launch tsserver)
Plug 'Shougo/vimproc.vim', {'do': 'make'}

" Installs fish syntax support
Plug 'dag/vim-fish'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_conceal_code_blocks = 0

call plug#end()


" Theme stuff
" If you have vim >=8.0 or Neovim >= 0.1.5
" if (has("termguicolors"))
"    set termguicolors
" endif

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
set nocompatible " be iMproved, required
if &term =~ '256color'
    set t_ut=
endif

" let ayucolor="mirage"

" set t_Co=256
" set background=dark
" colorscheme two-firewatch
" 
" Fixes for ugly gutter colouring:
"colorscheme gotham256
colorscheme challenger_deep
let g:lightline = { 'colorscheme': 'challenger_deep'}

"hi LineNr term=NONE cterm=NONE ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi Normal guibg=Black ctermbg=Black
hi LineNr ctermbg=Black term=NONE cterm=NONE

" Identline config
" IndentLine {{
let g:indentLine_char = ''
let g:indentLine_first_char = ''
let g:indentLine_showFirstIndentLevel = 2
let g:indentLine_setColors = 10 
" }}

" airline stuff
" let g:airline_theme = 'gotham256'
" let g:airline_powerline_fonts = 1 

" get the right python
let g:python2_host_prog = '/usr/local/bin/python2.7'

" let g:python3_host_prog = '/usr/local/bin/python3.7'

" nerdtree config
" map toggle NERDTree to ^Ctrl + n
map <C-N> :NERDTreeToggle<CR>

" show hidden files by default
let NERDTreeShowHidden=1

" ignore specifc files
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.DS_Store']

" syntastic config 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" end syntastic config

" for nerdcommenter
filetype plugin on
filetype plugin indent on

"syntax on
"syntax enable
" Inconsistent behaviour with syntax? 
if !exists("g:syntax_on")
    syntax enable
endif

set ruler                       " Show the line and column numbers of the cursor.
" set formatoptions+=o          " Continue comment marker in new lines.
set textwidth=0                 " Hard-wrap long lines as you type them.
set modeline                    " Enable modeline.

set noerrorbells                " No beeps
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set encoding=utf-8              " Set default encoding to UTF-8
set laststatus=2
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set nostartofline               " Don't reset cursor to start of line when moving around
set nowrap                      " Do not wrap lines
set nu                          " Enable line numbers
set clipboard=unnamed           " Attempting to use macos clipboard 
set tabstop=4 shiftwidth=4 expandtab
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set gdefault                    " Use 'g' flag by default with :s/foo/bar/.
set magic                       " Use 'magic' patterns (extended regular expressions).
set nolist                      " hides tabs (I think?)

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <A-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <A-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" map <Esc>[A <Up>
"map <Esc>[B <Down>
"map <Esc>[C <Right>
"map <Esc>[D <Left>

nnoremap <A-Left> :tabprevious<CR>
nnoremap <A-Right> :tabnext<CR>

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

