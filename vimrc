set nocompatible
"source $VIMRUNTIME/mswin.vim
"behave mswin

set tabstop=4
set shiftwidth=4
set expandtab

set number

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

set tags+=tags,tags.vendor

" F8 to open tagbar
nmap <F8> :TagbarToggle<CR>

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

" Buffer Keymaps
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" Tab Keymaps
nnoremap tj  :tabfirst<CR>
nnoremap tl  :tabnext<CR>
nnoremap th  :tabprev<CR>
nnoremap tk  :tablast<CR>
nnoremap tt  :tabnew<CR>
nnoremap tx  :tabclose<CR>

" Quicklist Keymaps
nnoremap [c :cp<CR>
nnoremap ]c :cn<CR>

" Refresh CtrlP
map <silent> <F6> :CtrlPClearCache<CR>

" CtrlP Fuzzy Search Tags
map <M-p> :CtrlPTag<CR>

" Refresh Syntax Highlighting when F12 is pressed
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Soft Wrap
set wrap linebreak nolist

" Disable Beep
set belloff=all

" Don't Change CtrlP Working Path When Opening Files
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 100000
let g:ctrlp_max_depth = 80

" Only use lexima for newline operations
" let g:lexima_enable_basic_rules = 0

" Automatically reload files when they are changed by another program
set autoread
au FocusGained,BufEnter * :checktime
au CursorHold * checktime 

set hlsearch
set incsearch
syntax on

" Make grep work recursively and avoid common dependency folders
set grepprg=grep\ -nIR\ --exclude='*~'\ --exclude='*.swp'\ --exclude-dir='vendor'\ --exclude-dir='node_modules'\ --exclude='tags'\ --exclude='tags.vendor'

" Persistent Undo
    call system('mkdir /tmp/vim')
if has('persistent_undo')
    set undodir=/tmp/vim
    set undofile
endif

" Put backups in /tmp
set backupdir=/tmp/vim

" Map double-space to clear highlighting
map <silent> <Space> :noh<CR>

" Highlight current line when not in insert mode
set cul
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul
autocmd WinLeave * setlocal nocul
autocmd WinEnter * setlocal cul

" Stop CtrlP from searching dependancies and temporary files
let g:ctrlp_custom_ignore = '\v[\/](node_modules|vendor)|(\~$)|(\.(swp|ico|git|svn))$'

" :bufonly closes all but the current buffer
command Bufonly :%bd|e#
