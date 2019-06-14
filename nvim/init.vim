" my nvim config

" Plugin list starts
call plug#begin('~/.dotfiles/nvim/plugged')

" Plugins
Plug 'whatyouhide/vim-gotham'
Plug 'gf3/molotov'
Plug 'arcticicestudio/nord-vim'
Plug 'fcpg/vim-orbital'
Plug 'https://github.com/rakr/vim-two-firewatch.git'
Plug 'jacoborus/tender.vim'
Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'https://github.com/cocopon/iceberg.vim.git'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree' " nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin' " nerdtree git int 
" Plug 'Valloric/YouCompleteMe' " completion
Plug 'sjl/vitality.vim' " play nice with iterm2

Plug 'vim-syntastic/syntastic' " find sytnax errors
Plug 'jiangmiao/auto-pairs' " auto pairs brackets
Plug 'tpope/vim-surround' " deal with surrounding in pairs
Plug 'tpope/vim-fugitive' " git commands
Plug 'airblade/vim-gitgutter' " shows git status in gutter

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

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

call plug#end()

" Set 256 colours, dark background, and molotov
"

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

"set t_Co=256
set background=dark
"colorscheme molotov
" :w
" colorscheme orbital
" colorscheme iceberg

syntax enable
"colorscheme tender
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu



" get the right python
let g:python2_host_prog = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.6'

" nerdtree config
" map toggle NERDTree to ^Ctrl + n
map <C-N> :NERDTreeToggle<CR>

" show hidden files by default
let NERDTreeShowHidden=1

" ignore specifc files
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$']

" syntastic config 
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" end syntastic config


"if filereadable("~/.dotfiles/nvim/color/molotov.vim")
"  colorscheme molotov
"end
set t_Co=256
set background=dark
colorscheme molotov
" colorscheme iceberg

"let g:airline_theme = 'molotov'
"let g:airline_powerline_fonts = 0
" for nerdcommenter
filetype plugin on
filetype plugin indent on

syntax on
set ruler               " Show the line and column numbers of the cursor.
" set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
" set modeline            " Enable modeline.

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
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set nu " Enable line numbers

" set tabstop=4 shiftwidth=4 expandtab
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Leader key is like a command prefix. 
" let mapleader='z'
 "let maplocalleader='\'

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

