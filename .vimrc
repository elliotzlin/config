" Vundle configs
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" NERDTree is a file system explorer
Plugin 'scrooloose/nerdtree'

" ctrlp is a fuzzy file, buffer, mru, tag, etc finder
Plugin 'ctrlpvim/ctrlp.vim'

" ale is an asynchronous lint engine, which lints as you type
Plugin 'w0rp/ale'

" improved javascript syntax highlighting
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" typescript syntax highlighting
Plugin 'leafgarland/typescript-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Indentation settings
set expandtab
set tabstop=2
set shiftwidth=2

" Display line numbers
set number

" Display relative line numbers
" set relativenumber

" Display column number
set ruler

" Better command-line completion
set wildmenu

" Preferred color scheme
colo deus

" Enable syntax highlighting
syntax on

" NERDTree config
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowHidden = 1

" ctrlp config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'

" make ctrlp go faster
set wildignore+=*.o,*.obj,.git,*/tmp/*,*/node_modules/*,*/bower_components*,*.so,*.swp,*.zip

" vim-javascript config
let g:jsx_ext_required = 0

" ALE configs
let g:ale_fixers = {
      \'javascript': ['eslint'],
      \'python': ['autopep8'],
      \}
