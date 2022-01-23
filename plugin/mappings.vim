"folding
nnoremap <leader>k :call fold#Move_to_prev_fold()<cr>
nnoremap <leader>j :call fold#Move_to_next_fold(0)<cr>

"insert mode mappings
inoremap jk <esc>
inoremap <c-d> <c-r>=enhance_ctrl_d#Enhance_ctrl_d()<cr>
inoremap <c-f> <esc>:call status_line#Set_status_line(1)<cr>i

" ctags: run the ctags program in the shell with F5
" (note :cd will get the shell in the appropriate spot)
nnoremap <C-]> :call tags#Open_tag_in_new_tab()<cr>

"easy resizing of windows
nnoremap <c-left>   <c-w><
nnoremap <c-right>  <c-w>>
nnoremap <c-up>     <c-w>+
nnoremap <c-down>   <c-w>-
nnoremap <a-w>      <c-w><c-w>
nnoremap <c-a-w>    <c-w>r

"changing brackets
nnoremap <leader>p :call brackets#B_chg_brackets()<cr>

"text width change (for comments)
nnoremap <leader>w :call ToggleTextWidth()<cr>

function! ToggleTextWidth()
    if &textwidth==0
        if &ft=='matlab'
            setlocal textwidth=75
            echo "setlocal textwidth=75"
        else
            setlocal textwidth=78
            echo "setlocal textwidth=78"
        endif
    else
        setlocal textwidth=0
        echo "setlocal textwidth=0"
    endif
endfunction

"toggle syntax (useful for latex files where syntax highlighting is slow)
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax on
    endif
endfunction

nnoremap <leader>x :call ToggleSyntax()<cr>
nnoremap <leader>h :nohl<cr>

function! RemoveWhiteSpace()
    try
        %substitute/\v(^\s+$|\S\zs\s+$)/
        execute "normal! \<c-o>"
    catch
        echo "no whitespace found"
    endtry

    nohl
endfunction

"highlighting/removal of extra whitespace
highlight ending_whitespace ctermbg=LightGrey guibg=LightGray
nnoremap <leader>z :call RemoveWhiteSpace()<cr>

function! AddHeader(txt)
    execute "normal! ^"
    let num_spaces=col('.') - 1
    execute "normal! o"
    if num_spaces > 0
        execute "normal! ".num_spaces."i "
    endif
    let len=strlen(getline(line('.')-1)) - num_spaces
    execute "normal! ".len."a".a:txt
endfunction

nnoremap <localleader>- :call AddHeader('-')<cr>
nnoremap <localleader>= :call AddHeader('=')<cr>

"initialization for when vim starts up
"will call S:Set_status_line for function parameters
set laststatus=2
call status_line#Set_status_line(0)

"saving
nnoremap <leader>s :w<cr>

"making
nnoremap <localleader>m :make!<cr>
