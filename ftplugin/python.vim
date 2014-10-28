" comments
vnoremap <buffer> <localleader>ac :<bs><bs><bs><bs><bs>call align#Align_comments("#", 1)<cr>
nnoremap <buffer> <localleader>ac :call align#Align_comments("#", 0)<cr>
nnoremap <buffer> <localleader>cb o<esc>60i#<esc>o# <cr><esc>60i#<esc>kA

"fold method
setlocal foldmethod=indent

"comments dont do very well when the fold method is indent
"see details here: http://stackoverflow.com/questions/8993455/how-do-i-fix-vim-to-properly-indent-folds-containing-python-comment-lines
setlocal comments=:#
setlocal formatoptions+=roc      "make sure to insert a comment after enter and o when the existing line is a comment
setlocal nosmartindent

" compilation
setlocal makeprg=python\ %
setlocal efm=%A\ \ File\ \"%f\"\\,\ line\ %l%m,%Z%[%^\ ]%\\@=%m
"setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
nnoremap <buffer> <localleader>m :make!<cr>
