"tex files get really slow with long lines.
"since this is due to syntax highlighting, limit it to only the first 100
"columns.
" setlocal synmaxcol=100
setlocal foldlevelstart=99
" iabbrev == &=&
setlocal indentexpr=
setlocal foldmethod=expr
setlocal concealcursor=

" for latex
function! Set_concealcursor()
    if len(&concealcursor) == 0
        setlocal concealcursor=n
    else 
        setlocal concealcursor=
    endif 
endfunction
setlocal concealcursor=
nnoremap <localleader>ln :call Set_concealcursor()<cr>

