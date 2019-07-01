" Set up PHP 'use' import plugin
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>

" Sort php 'use' statements when inserting a new one
let s:php_namespace_sort_after_insert = 1

" Stop CtrlP from searching dependancies and temporary files
let g:ctrlp_custom_ignore = '\v[\/](node_modules)|(\~$)|(\.(swp|ico|git|svn))$'

" Automatically rerun ctags on buffer write
if filereadable("directories_to_ctag")
    au BufWritePost *.php silent! !ctags -R --PHP-kinds=cfit --language-force=PHP -L directories_to_ctag
endif

" Run Larastan static analysis when calling make
let &makeprg="php artisan code:analyse --no-tty --error-format=raw --no-progress \\| grep -vE 'Call to an undefined method Illuminate.+View::with.+()'"
setlocal errorformat=%f:%l:%m
