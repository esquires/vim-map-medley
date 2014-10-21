""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" purpose: code to align equal signs and comments
"
" last updated: 12/1/2013
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! align#Align_comments(char, multiline)
"Purpose: aligns inline comments (comments after assignment statements) on
"         multiple lines
"
"6 cases: 1) nothing found
"         2) comment starts in the appropriate column
"         3) there is a comment, but it is not coming after a command
"            (i.e., the line is only a comment). in this case do nothing.
"         4) the comment is too far left:  just add spaces
"         5) the command takes up too much space to fit a comment in the
"            desired column.  put the comment at the next tab stop after the
"            command
"         6) the comment is too far right: remove spaces

    "default setting for comment alignment
    if !exists("g:comment_col")
        let g:comment_col = 45
    endif

    "define basic parameters
    if a:multiline
        let beg_line   = line(".")
        let num_lines  = line("'>") - line("'<") + 1
        let end_line   = beg_line + num_lines - 1
        execute "normal! " . beg_line . "G0"
    else
        let beg_line   = line(".")
        let end_line   = line(".")
    endif


    "loop through every line, updating the position of the character
    while end_line >= line(".")

        "find the comment and get some information
        execute "normal! f" . a:char

        "booleans for case 1, 2, and 3
        let txt_before_char  = getline('.')[0:col('.')-2]
        let cmt_only_line    = (col(".") == 1 || match(getline('.')[0:col('.')-2],'\S') == -1)  "look for non-whitespace characters
        let temp_comment_col = col(".")

        if (temp_comment_col == 1) || temp_comment_col == g:comment_col || cmt_only_line

            "cases 1,2, and 3:  do nothing

        elseif temp_comment_col < g:comment_col

            "case 4:  comment is too far left, just add spaces
            let spaces_to_add = g:comment_col - temp_comment_col
            execute "normal! " . spaces_to_add . "i "

        else

            "find the end of the previous word
            "note that this command will not take you to the
            "previous line because case 3 has already been checked
            execute "normal! ge"

            "find the next tabstop (using integer division on purpose)
            let next_tab_stop = ( (col(".") / &tabstop) + 1) * 4 + 1

            if col(".") >= g:comment_col

                "case 5:  command takes up too much space

                "go back to the comment
                execute "normal! f" . a:char

                "if the comment is beyond the tabstop, then take away space,
                "otherwise, add space
                if col(".") > next_tab_stop
                    execute "normal! " . (col(".") - next_tab_stop) . "hdw"
                elseif col(".") < next_tab_stop
                    let spaces_to_add = next_tab_stop - col(".")
                    execute "normal! " . spaces_to_add . "i "
                endif

            else

                "case 6: just delete the extra whitespace
                execute "normal! f" . a:char
                execute "normal! " . (col(".") - g:comment_col) . "h"
                execute "normal! dw"

            endif
        endif

        "finish if at end of file
        if line(".") == line("$")
            break
        endif

        execute "normal! 0j"
    endwhile

    execute "normal! " . beg_line . "G0"
    echo "Alignment complete.  To change comment alignment column:  let g:comment_col = # (default = 45) (or use <ll>aa)"
endfunction

function! align#Align_equals()
"Purpose:       aligns the equal signs of the current visual selection
"
"Assumptions:   1) function is called during visual mode. if this is not the
"                  case, then it will operate on the previous visual selection
"
"               2) there are no tabs (i.e., expandtab is set to true)
"
"               3) there are not equals signs in the first column that need to
"                  be aligned

    "define basic parameters
    let beg_line  = line(".")
    let num_lines = line("'>") - line("'<") + 1
    let tgt_col   = Calc_tgt_col(beg_line, num_lines)

    "loop through every line, updating the position of the character
    let loop_ct = 0

    while loop_ct < num_lines

        let loop_ct += 1

        "find the character
        execute "normal! f="

        "if there is no equals, do nothing
        if col(".") == 1

            execute "normal! 0j"
            continue

        endif

        "if there is a special char,
        if getline(".")[col(".")] == "="

            let temp_tgt_col = tgt_col - 1

        elseif Special_char_bf()

            let temp_tgt_col = tgt_col - 1
            execute "normal! h"

        else

            let temp_tgt_col = tgt_col

        endif

        "if spaces need to be added
        if temp_tgt_col > col(".")

            let to_add = temp_tgt_col - col(".")
            execute "normal! " . to_add . "i "

        elseif temp_tgt_col < col(".")

            let to_del = col(".") - temp_tgt_col
            execute "normal! " . to_del . "hdw"

        endif

        "go to next line
        execute "normal! 0j"

    endwhile

endfunction

function! Calc_tgt_col(beg_line, num_lines)
"the target column will be as far left as possible
"algorithm: start with a large tgt column and update with each line as
"follows:
"
"1) there is no equals sign: no update
"2) if there is an equals sign
"   - check the ending of the previous word. after the end of the
"      word, there should be 1 space followed by the equals sign
"   - the exception is when there is any of [><+-*/!~]. In this case,
"      offset the target by 1 additional
"   - in either case,  tgt_col = max(tgt_col, this_line's_tgt_col)

    let pos = getpos(".")

    "go to the first line again
    execute "normal! " . a:beg_line . "G0"

    let tgt_col = -1
    let any_special_char = 0
    let loop_ct = 0

    while loop_ct < a:num_lines

        let loop_ct += 1
        let ln = line(".")

        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " first find the equals sign
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        execute "normal! 0f="

        "condition 1 above: if there is no equals sign, do nothing
        if col(".") == 1
            execute "normal! 0j"
            continue
        endif

        "the character is special if there is [><+-*/!~] before the equals
        "sign or a double equals sign
        let any_special_char = any_special_char || Special_char_bf() || getline(".")[col(".")] == "="

        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " check previous word
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        execute "normal! ge"

        "there is no word before the equals sign: do nothing
        if (line(".") != ln)
            execute "normal! 0j"
            continue
        endif

        """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " calculate the new target column
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        let tgt_col = max([tgt_col, col(".") + 2])

        "go to next line
        execute "normal! 0j"

    endwhile

    if any_special_char
        let tgt_col += 1
    endif

    call setpos('.',pos)
    return tgt_col
endfunction

function! Special_char_bf()
    let char_bf_eq = getline(".")[col(".")-2]
    let is_special_bf = (match(char_bf_eq,"[-<>+*/!~]") != -1)
    return is_special_bf
endfunction
