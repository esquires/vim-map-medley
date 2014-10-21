" comments
vnoremap <buffer> <localleader>ac :<bs><bs><bs><bs><bs>call align#Align_comments("/", 1)<cr>
nnoremap <buffer> <localleader>ac :call align#Align_comments("/", 0)<cr>
nnoremap <buffer> <localleader>cb o/<esc>59i/<esc>o<cr><esc>58i/<esc>kA

"fold method
set foldmethod=syntax

"handling comments
setlocal formatoptions+=roct

nnoremap <localleader>m :make!<cr>
