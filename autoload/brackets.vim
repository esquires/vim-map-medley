"contains code to change bracket types
"
"example:
"   foo = fah[1]
"
"   after putting the cursor on '[' or ']'
"   and typing <leader>p (mapping in .vimrc)
"   the result is
"
"   foo = fah(1)

function! brackets#B_chg_brackets()

	"define position variables
	let old_pos = getpos(".")			"save original cursor position
	execute "normal! %"

	let new_pos = getpos(".")			"get new position after jumping to corresponding bracket

	"3 cases: no jump, jump forward, jump backward
	if new_pos ==? old_pos

		"no jump -> no matching bracket, just exit
        echo "put cursor on bracket, '()[]{}', to use script"
		return

    endif

    let new_brackets = input("Enter replacement for brackets (blank deletes): ")
    if len(new_brackets) == 2

	    if (new_pos[1] > old_pos[1]) || (new_pos[1] ==? old_pos[1] && new_pos[2] > old_pos[2])

            "jump forward:  this occurs when...
            "1) new_pos line is after old_pos line (index 1) OR
            "2) new_pos and old_pos are on the same line but new_pos column is after old_pos column
            let new_pos_bracket = new_brackets[1]
            let old_pos_bracket = new_brackets[0]

        else

            "jump backward
            let new_pos_bracket = new_brackets[0]
            let old_pos_bracket = new_brackets[1]

        endif

        "now replace brackets
        execute "normal! r" . new_pos_bracket
        call setpos('.',old_pos)
        execute "normal! r" . old_pos_bracket

    else

	    if (new_pos[1] > old_pos[1]) || (new_pos[1] ==? old_pos[1] && new_pos[2] > old_pos[2])
            execute "normal! x"
            call setpos('.',old_pos)
            execute "normal! x"
        else 

            "cursor started at end of pair when it is deleted, the "old_pos"
            "will move down 1 column (except when it started at the beginning
            "of a line)
            if old_pos[2] != 1
                let old_pos[2] -= 1
            endif  

            execute "normal! x"
            call setpos('.',old_pos)
            execute "normal! x"
        endif 

    endif

    echo ""
endfunction
