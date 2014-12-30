"so that <alt-h> works, etc
"see http://vim.wikia.com/wiki/Key_maps_using_the_Alt_modifier
:set winaltkeys=no

"look and feel {{{
syntax on           " enable syntax highlighting
set showmode		" show the editing mode on the last line
set autoindent	    " indent based on previous line
set smartindent
set number          " starting with Vim 7.4, nu and rnu can be simultaneous
set relativenumber	" include line numbers
set ruler
set nowrap          " do not wrap automatically
set tabstop=4
set shiftwidth=4    " 1 tab = 4 spaces
set expandtab
" }}}

"search settings {{{
set hlsearch		" highlight search
set incsearch		" search while typing
set ignorecase		" guess whether case sensitive or not
" }}}

"other settings  {{{
syntax spell toplevel
set wildmode=longest,list	" make command line work like bash
set history=1000             " length of history for q:
set foldcolumn=0
set foldmethod=indent
set foldignore=
set foldnestmax=3
set foldminlines=5
"" }}}

"remove toolbar, menubar, and left scrollbar in GVIM {{{
set guioptions-=m
set guioptions-=T
set guioptions-=L
" }}}

"allow lines to wrap with lists (n) and when joining lines,
"remove the comment marker (j)
set formatoptions+=nj
