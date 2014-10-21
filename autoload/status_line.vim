function! status_line#Get_func_params()
    " finds a nearby function, follows the tag, and puts
    " parameter information onto the statusline

    "set original position
    let orig_pos = getpos(".")

    " get the character under the cursor
    "stopinsert
    let char_under_cursor = getline('.')[col('.')-1]

    " go to the associated function
    if char_under_cursor ==# "("
        "already at opening parenthesis
        execute "normal! b"
    else
        "go to visual mode and find associated parenthesis
        execute "normal! vi(oh"

        "if the last line still did not find a parenthesis
        "then there are probably not matching parenthesis,
        "just do a backward search for '('
        let char_under_cursor = getline('.')[col('.')-1]
        if char_under_cursor ==# "("
            execute "normal! \<esc>hb"
        else
            execute "normal! \<esc>F(hb"
        endif

    endif

    let func = expand("<cword>")

    " follow the tag
    try
        execute "tag " . func
    catch /^Vim\%((\a\+)\)\=:E/
        echo "tag for " . func . " not found.  Cannot find parameters."
        call setpos('.',orig_pos)
        return " "
    endtry

    "get the parenthesis
    execute "normal! f("
    let pos_paren = getpos(".")

    "go to the beginning of the line and skip the first word (it is usually "function" or "def")
    execute "normal! ^w"
    let pos_start = getpos(".")

    "get the information in the parenthesis
    call setpos('.',pos_paren)
    execute 'normal! "py%'

    "the overall parameters
    let params = getline('.')[pos_start[2]-1:pos_paren[2]-2] . @p

    "remove unnecessary white space and new lines
    let params = substitute(params,'\n',' ','')
    let params = substitute(params,'\s\{2,}',' ','')

    "return to original location
    call setpos('.',orig_pos)
    return params
endfunction

function! Set_status_line_helper()
    "had to add this so that the line
    "exec "set statusline+=%{Myprint()}"
    "would work
    return g:params_for_status_line
endfunction

function! status_line#Set_status_line(add_func_params)

    set statusline=
    if a:add_func_params
        let g:params_for_status_line = status_line#Get_func_params()

        if g:params_for_status_line != " "
            exec "set statusline+=%{Set_status_line_helper()}"
        endif
    endif

    set statusline+=%10l/%-10L	"line number / total lines
    set statusline+=%-10c
    set statusline+=%-20y		"show the file-type

    set statusline+=%=			"now go to the right side of the statusline
    set statusline+=%-3m
    set statusline+=%F			"full path on the right side

endfunction
