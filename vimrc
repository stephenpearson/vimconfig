set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'kien/ctrlp.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nanotech/jellybeans.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/sparql.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'hashivim/vim-vagrant'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform'

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

set hidden
let g:racer_cmd = "/Users/stephen/Code/rust/racer/target/release/racer"
let $RUST_SRC_PATH="/Users/stephen/Code/rust/lang/rust/src"

" All of your Plugins must be added before the following line
call vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

" For OSX
if has('gui_running')
  set guifont=Monaco\ for\ Powerline:h14
endif

" On Linux, prefer Droid Sans
" Obtain fonts from here: https://github.com/powerline/fonts.git
if has("gui_gtk2")
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 14
endif
if has("gui_gtk3")
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 14
endif

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
 let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" let g:airline#extensions#tabline#enabled = 1

set t_Co=256
set laststatus=2

set number
set wildmenu
set wildmode=list:longest
set title
set softtabstop=2
set shiftwidth=2
set tabstop=2
set noautoindent
set expandtab
syntax enable
syntax on
" set background=dark
colorscheme jellybeans
let g:jellybeans_use_lowcolor_black = 0

let g:ctrlp_working_path_mode = 2
let g:ctrlp_switch_buffer = 0
let g:ctrlp_max_files = 20000

let mapleader=","
let maplocalleader=","
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t :CtrlP<CR>
map <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>
map <leader>b :CtrlPBuffer<CR>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>cd :cd %:h

" let g:netrw_keepdir=0

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

let &colorcolumn=join(range(81,999),",")
let @u='i# -*- coding: utf-8 -*-'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

highlight LineNr ctermfg=white ctermbg=0

" Show ctrl-p hidden file
let g:ctrlp_show_hidden = 1

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Remap because iterm2 doesn't pass c-tab
let g:UltiSnipsListSnippets="<s-tab>"

map <leader>se :UltiSnipsEdit<cr>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gq :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" Split shortcuts
nnoremap <leader>vs :vsplit<cr>
nnoremap <leader>hs :split<cr>

nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>
