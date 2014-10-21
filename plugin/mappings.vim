"folding
nnoremap <leader>k :call fold#Move_to_prev_fold()<cr>
nnoremap <leader>j :call fold#Move_to_next_fold(0)<cr>
nnoremap <A-j> :call fold#Move_to_next_fold(1)<cr>
nnoremap <A-k> :call fold#Close_fold_and_move_up()<cr>
nnoremap <c-u> za

"insert mode mappings
inoremap jk <esc>
inoremap <c-d> <c-r>=enhance_ctrl_d#Enhance_ctrl_d()<cr>
inoremap <c-f> <esc>:call status_line#Set_status_line(1)<cr>i

" ctags: run the ctags program in the shell with F5
" (note :cd will get the shell in the appropriate spot)
nnoremap <f5> :!ctags -R<CR>
nnoremap <C-]> :call tags#Open_tag_in_new_tab()<cr>

"easy movement between tabs (yes gt and <c-page> work, but this seems easier)
nnoremap <c-l> gt
nnoremap <c-h> gT

" alignment stuff
    "easy access to change comment col: user will be reminded when using <localleader>ac
    nnoremap <localleader>aa :let g:comment_col=

    "align equals
    vnoremap <localleader>ae :<bs><bs><bs><bs><bs>call align#Align_equals()<cr>

"changing brackets
nnoremap <leader>p :call brackets#B_chg_brackets()<cr>

"text width change (for comments)
nnoremap <leader>w :call ToggleTextWidth()<cr>

function! ToggleTextWidth()
    if &textwidth==0
        setlocal textwidth=78
        echo "setlocal textwidth=78"
    else
        setlocal textwidth=0
        echo "setlocal textwidth=0"
    endif
endfunction

"toggle line numbers
nnoremap <leader>n :call line_numbers#ToggleNumber()<cr>

"toggle syntax (useful for latex files where syntax highlighting is slow)
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax on
    endif
endfunction

nnoremap <leader>x :call ToggleSyntax()<cr>

"highlighting/removal of extra whitespace
highlight ending_whitespace ctermbg=LightGrey guibg=LightGray
nnoremap <leader>z :%s/\v(\S\zs\s+$\|^\s+$)/<cr> :execute "normal! \<c-o>"<cr> :nohl<cr>

let g:show_ending_whitespace = 1
nnoremap <leader>Z :call Toggle_show_ending_whitespace()<cr>
function! Toggle_show_ending_whitespace()
    if g:show_ending_whitespace
        match ending_whitespace /\v(\S\zs\s+$|^\s+$)/
        let g:show_ending_whitespace = 0
        echo "showing whitespace errors"
    else
        match none ending_whitespace
        let g:show_ending_whitespace = 1
        echo "not showing whitespace errors"
    endif
endfunction

"initialization for when vim starts up
"will call S:Set_status_line for function parameters
set laststatus=2
call status_line#Set_status_line(0)

"saving
nnoremap <leader>s :w<cr>
