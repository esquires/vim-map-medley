" comments
vnoremap <buffer> <localleader>ac :<bs><bs><bs><bs><bs>call align#Align_comments("%", 1)<cr>
nnoremap <buffer> <localleader>ac :call align#Align_comments("%", 0)<cr>
nnoremap <buffer> <localleader>cb o%<esc>59i%<esc>o<cr><esc>59i%<esc>kA

"fold method
setlocal foldmethod=indent
setlocal foldlevel=1

"handling comments
setlocal comments=:%
setlocal formatoptions+=roc
