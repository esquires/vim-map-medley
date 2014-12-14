"tex files get really slow with long lines.
"since this is due to syntax highlighting, limit it to only the first 100
"columns. For some reason this does not seem to affect other filetypes
setlocal synmaxcol=70
iabbrev == &=&
setl indentexpr=
