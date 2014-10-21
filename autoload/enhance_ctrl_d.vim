"purpose: alter <c-d> in insert mode as follows
"   if there is all spaces prior to the cursor, function normally
"   otherwise, remove spaces up to the previous tabstop or, if there is a word
"   in the way, remove all spaces up to the end of the previous word

function! enhance_ctrl_d#Enhance_ctrl_d()

    "setup initial variables (ts is the location of the target tab stop)
    let done = 0
    let ts   = ((col(".") - 2) / 4)*4 + 1

    "keep backspacing until one of the following is met
    "1) reached the beginning of the line: col = 1
    "2) reached a word boundary
    "3) reached a tabstop
    while !done

        let beg_of_line   = (col(".") == 1)
        let word_boundary = (match(getline(".")[col(".")-3], '\S')>=0)
        let hit_ts        = (col(".") == ts)

        echom beg_of_line . word_boundary . hit_ts

        if beg_of_line || hit_ts

            let done = 1

        elseif word_boundary

            execute "normal hx"
            let done = 1

        else

            execute "normal hx"

        endif

    endwhile

    return ""
endfunction
