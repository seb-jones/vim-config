set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set tabstop=4
set shiftwidth=4
set expandtab

set number

set lines=39
set columns=84

set wildmode=longest,list,full
set wildmenu

if has("gui_running")
    colorscheme gruvbox
    set background=dark

	if (has("gui_win32"))
		set guifont=DejaVu_Sans_Mono:h12
    else
		set guifont=DejaVu\ Sans\ Mono\ 11
	endif
else
    colorscheme default
endif

set encoding=utf-8

filetype plugin indent on

" Persistent Undo
"set undodir=C:\Users\Seb\vimfiles\undodir
"set undofile

" Custom Backup Directory
"set backupdir=C:\Users\Seb\vimfiles\backupdir

map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <F5>  :NERDTreeRefreshRoot<CR>

set tags+=tags,tags.vendor

" Set up PHP 'use' import plugin
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" Sort php 'use' statements when inserting a new one
let g:php_namespace_sort_after_insert = 1

" Stop CtrlP from searching dependancies and temporary files
let g:ctrlp_custom_ignore = '\v[\/](node_modules|vendor)|(\~$)|(\.(swp|ico|git|svn))$'

" \q to delete buffer without closing the split window
:nnoremap <Leader>q :Bdelete<CR>

" F8 to open tagbar
nmap <F8> :TagbarToggle<CR>

" Automatically rerun ctags on buffer write
if filereadable("directories_to_tag.seb")
    au BufWritePost *.php silent! !ctags -R --PHP-kinds=cfit -L directories_to_tag.seb
endif

" Window Keymaps
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-Up> :resize +5<CR>
nnoremap <C-Down> :resize -5<CR>
nnoremap <C-Left> :vertical resize -5<CR>
nnoremap <C-Right> :vertical resize +5<CR>

nnoremap <C-s> :vsp<CR>
nnoremap <C-_> :sp<CR>

 "nnoremap <C-d> :q<CR>

" Refresh CtrlP
map <silent> <F6> :CtrlPClearCache<CR>

" CtrlP Fuzzy Search Tags
map <M-p> :CtrlPTag<CR>

" Use grep instead of windows' FindStr for multi-file search
set grepprg=grep\ -nR\ --exclude=*~\ --exclude=*.swp\ --exclude-dir=vendor\ --exclude-dir=node_modules\ --exclude=tags\ --exclude=tags.vendor

" Refresh Syntax Highlighting when F12 is pressed
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Soft Wrap
set wrap linebreak nolist

" Disable Beep
set belloff=all

" Don't Change CtrlP Working Path When Opening Files
let g:ctrlp_working_path_mode = 0

" Only use lexima for newline operations
let g:lexima_enable_basic_rules = 0

" Automatically reload files when they are changed by another program
set autoread
