Vim Map Medley
===

Installation
---

If using Pathogen,

    1) place vim-map-medley directory in .vim/bundle
    2) In vim, run ":Helptags"
    3) Anytime you need help, just type ":h vim_map_medley.txt"

If not using Pathogen,

    1) place vim-map-medley contents in .vim/
    2) In vim, run ":helptags"
    3) Anytime you need help, just type ":h vim_map_medley.txt"

If you don't have a local leader set, put the following in your .vimrc

    let maplocalleader = "\\"
    let mapleader = "\<space>"


Mapping Summary
---

1) Formatting

    * \ac             - align comments to the right of function calls
    * \aa             - change target column for <localleader>ac
    * \cb             - comment block (for c, matlab, python)
    * <space>w        - toggle text width between 0 and 78
    * \-, \=          - add a row of "-" or "=" of length equal to the previous line

2) Programming Functions

    * <f5>            - runs ctags in the system shell
    * <c-f>           - prints the function parameters in the statusline (in insert mode)
    * \ae             - align equal signs in the visual selection
    * <space>p        - change bracket type
    * <space>n        - toggle line numbers
    * \m              - "run" the current file (for python, vim, and c files only)
    * <space>x        - toggle syntax on/off
    * <space>z        - remove trailing whitespace (e.g., for use with git)

3) Insert mode mappings

    * jk              - in insert mode, this switches back to normal mode
    * <c-d>           - enhanced control d
    * <c-f>           - prints the function parameters in the statusline

4) Folding Enhancements

    * <space>j        - puts cursor at next fold (or end of file if there is no fold)
    * <space>k        - puts cursor at previous fold (or beg of file if there is no fold)
    * <a-j>           - opens the current fold (if applicable) and goes to the next fold
    * <a-k>           - closes the current fold (if applicable) and goes to the prev fold
    * <c-u>           - toggle fold (same as za)

5) Splits

    * <a-w>           - switch between split windows
    * <c-left>        - decrease split width
    * <c-right>       - increase split width
    * <c-down>        - decrease split height
    * <c-up>          - increase split height

6) Other

    * <space>s        - save buffer (mapped to ":w<cr>")
    * <space>h        - :nohl<cr>

7) License

        see LICENSE in the root directory
