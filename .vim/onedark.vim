" Disable italics in terminal because KiTTY + vim one dark will have very dark gray for
" Comment highlight
if &term=='nvim'
    " Enable in Neovim GUI
    let g:onedark_terminal_italics = 1
endif
" Removes the background color in terminal. This is a bit of an experimental option, and it cause issues in certain terminals
augroup colorset
    autocmd!
    " Fine tune colorscheme for hlsearch
    autocmd ColorScheme onedark call onedark#set_highlight("Search", { "fg": onedark#GetColors().yellow, "bg": onedark#GetColors().comment_grey })
    autocmd ColorScheme onedark call onedark#set_highlight("IncSearch", { "fg": onedark#GetColors().black, "bg": onedark#GetColors().yellow })

    " Fine tune colorscheme for syntax highlight
    autocmd ColorScheme onedark call onedark#set_highlight("Macro", { "fg": onedark#GetColors().cyan })
augroup END
