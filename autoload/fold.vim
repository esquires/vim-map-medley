"module provides capability to move to next/previous folds [z and zj did not
"seem to be working as desired. This implementation seems a bit more
"intuitive.
"
"If moving up or down, the cursor will stop at the next fold

function! fold#Move_to_prev_fold()

    "where to start
    let lnum = line(".")
    let fc = foldclosed(lnum)

    if fc == -1

        "no fold found on the current line, start here
        let lnum = line(".")

    elseif fc == 1

        "fold start found on line 1, just go straight there
        execute "normal! gg"
        return

    else

        "start at just above the current fold level
        let lnum = foldclosed(lnum) - 1
    endif

    "loop until you find another fold section
    let done = 0
    while !done

        let fc = foldclosed(lnum)

        if lnum <= 1

            "hit beginning of file
            let done = 1
            let goal_line = 1

        elseif fc == -1

            "no fold found yet, move up another line
            let lnum -= 1

        else

            "fold found, stop here
            let goal_line = fc
            let done = 1

        endif
    endwhile

    "go to that line
    execute "normal! " . goal_line . "G"
endfunction

function! fold#Move_to_next_fold(open_fold)

    if a:open_fold
        try
            foldopen
        catch
            "ignore the error that occurs when there is no fold
        endtry
    endif

    let beg_lnum = line(".")
    let lnum = line(".") + 1
    let done = 0

    while !done

        if foldclosed(lnum) > beg_lnum || lnum >= line("$")
            let done = 1
        else
            let lnum = lnum + 1
        endif
    endwhile

    execute "normal! " . lnum . "G"
endfunction

function! fold#Close_fold_and_move_up()

    try
        execute "normal! zc"
    catch
        "not in a fold, so just move to previous fold
        call fold#Move_to_prev_fold()
        return
    endtry

    let done = 0
    let orig_ln = line(".")

    while !done
        try
            execute "normal! zc"
        catch
            "ignore
        endtry

        let fc = foldclosed(line("."))

        if line(".") <= 1

            let done = 1

        elseif fc == -1

            "nothing folded, keep moving up
            execute "normal k"

        else

            "go to the top of the fold
            let ln = line(".")
            execute "normal! " . fc . "G"

            "if the above jump did not move, then keep moving up
            if line(".") <= 1

                "beginning of file
                let done = 1

            elseif line(".") == orig_ln

                execute "normal k"

            else

                "otherwise, you are done
                let done = 1
                "call fold#fold_prev#Move_to_prev_fold()
            endif
        endif
    endwhile
endfunction
