"Purpose: toggles absolute line numbering while keeping relative numbering at
"all times

function! line_numbers#ToggleNumber()
"if absolute line numbering is on, turn it off but keep relative numbering
"designed to be easily called from a keyboard mapping
    if v:version > 703
        let turn_on_abs = &relativenumber
    else
        let turn_on_abs = !&number
    endif

    if turn_on_abs
        call line_numbers#Turn_on_abs_line_numbers()
    else
        call line_numbers#Turn_off_abs_line_numbers()
    endif

endfunction

function! line_numbers#Turn_off_abs_line_numbers()
"designed to be incorporated into GainedFocus event
    if v:version > 703
        "setlocal number
        setlocal relativenumber
    else
        setlocal relativenumber
    endif
endfunction

function! line_numbers#Turn_on_abs_line_numbers()
"designed to be incorporated into LostFocus event
    if v:version > 703
        "setlocal number
        setlocal norelativenumber
    else
        setlocal number
    endif
endfunction
