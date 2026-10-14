set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8

" Prefer the Python Vim was built with, not a project venv
if has('python3')
  let g:python3_host_prog = exepath('python3')
endif

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
Plugin 'honza/vim-snippets'
Plugin 'hashivim/vim-vagrant'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform'
Plugin 'hrsh7th/vim-vsnip'
Plugin 'hrsh7th/vim-vsnip-integ'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on

let mapleader=","
let maplocalleader=","

" vim-vsnip
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

" Expand or jump forward
imap <expr> <Tab>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'

" Jump backward
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

nnoremap <leader>se :VsnipOpen<cr>

let g:filetype_pl="prolog"

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" coc mappings removed — delete these lines if you no longer use coc.nvim
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

set hidden
let g:racer_cmd = "/Users/stephen/Code/rust/racer/target/release/racer"
let $RUST_SRC_PATH="/Users/stephen/Code/rust/lang/rust/src"

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
colorscheme jellybeans
let g:jellybeans_use_lowcolor_black = 0

let g:ctrlp_working_path_mode = 2
let g:ctrlp_switch_buffer = 0
let g:ctrlp_max_files = 20000

map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t :CtrlP<CR>
map <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>
map <leader>b :CtrlPBuffer<CR>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>cd :cd %:h

function! ExtractLinesToFile() abort
  let l:target = input('Extract lines to: ', '', 'file')
  if empty(l:target)
    echo 'Cancelled'
    return
  endif

  let l:first = line("'<")
  let l:last  = line("'>")

  " Write first: if this fails, the source remains untouched.
  execute l:first . ',' . l:last . 'write ' . fnameescape(l:target)

  " Then remove the successfully extracted lines.
  execute l:first . ',' . l:last . 'delete'
endfunction

xnoremap <leader>x :<C-u>call ExtractLinesToFile()<CR>

function! UnindentVisualToMargin() range abort
  let l:widths = []

  for l:lnum in range(a:firstline, a:lastline)
    let l:text = getline(l:lnum)
    if l:text =~# '\S'            " ignore blank lines
      call add(l:widths, strlen(matchstr(l:text, '^ *')))
    endif
  endfor

  if empty(l:widths)
    return
  endif

  let l:amount = min(l:widths)
  execute a:firstline . ',' . a:lastline . 's/^ \{' . l:amount . '}//'
endfunction

xnoremap <leader>< :<C-u>'<,'>call UnindentVisualToMargin()<CR>

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

highlight LineNr ctermfg=white ctermbg=0

" Show ctrl-p hidden file
let g:ctrlp_show_hidden = 1

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

if exists('&t_ut')
  set t_ut=
endif

highlight Normal ctermbg=NONE guibg=NONE
highlight NormalNC ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" JSON indentation
autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab

" Reindent the whole JSON buffer with \j
autocmd FileType json nnoremap <buffer> <leader>j :%!prettier --parser json<CR>

function! s:CreateVsnipFromSelection() abort
  let l:lines = getline("'<", "'>")
  if empty(l:lines)
    echo "No selection"
    return
  endif

  let l:prefix = input("Snippet prefix: ")
  if empty(l:prefix)
    echo "Cancelled"
    return
  endif

  let l:desc = input("Description: ", l:prefix)
  let l:ft = &filetype
  if empty(l:ft)
    let l:ft = input("Filetype: ")
  endif
  if empty(l:ft)
    let l:ft = "all"
  endif

  let l:dir = expand(get(g:, 'vsnip_snippet_dir', '~/.vim/snippets'))
  call mkdir(l:dir, 'p')
  let l:file = l:dir . '/' . l:ft . '.json'

  let l:snippets = {}
  if filereadable(l:file)
    try
      let l:snippets = json_decode(join(readfile(l:file), "\n"))
    catch
      echoerr "Existing file is not valid JSON — fix it first: " . l:file
      return
    endtry
  endif

  let l:snippets[l:desc] = {
    \ "prefix": l:prefix,
    \ "body": l:lines,
    \ "description": l:desc
    \ }

  " Write compact, then pretty-print
  call writefile([json_encode(l:snippets)], l:file)
  if executable('jq')
    call system('jq . ' . shellescape(l:file) . ' > ' . shellescape(l:file) . '.tmp && mv ' . shellescape(l:file) . '.tmp ' . shellescape(l:file))
  elseif executable('python3')
    call system('python3 -m json.tool ' . shellescape(l:file) . ' > ' . shellescape(l:file) . '.tmp && mv ' . shellescape(l:file) . '.tmp ' . shellescape(l:file))
  endif

  echo "Saved snippet '" . l:prefix . "' to " . l:file
endfunction

xnoremap <leader>ns :<C-u>call <SID>CreateVsnipFromSelection()<CR>
