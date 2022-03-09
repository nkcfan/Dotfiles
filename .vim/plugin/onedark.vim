if has('nvim-0.5.0')
    finish
endif

augroup colorset
    autocmd!
    " Fine tune colorscheme for hlsearch
    autocmd ColorScheme onedark call onedark#set_highlight("Search", { "fg": onedark#GetColors().yellow, "bg": onedark#GetColors().comment_grey })
    autocmd ColorScheme onedark call onedark#set_highlight("IncSearch", { "fg": onedark#GetColors().black, "bg": onedark#GetColors().yellow })

    " Fine tune colorscheme for syntax highlight
    autocmd ColorScheme onedark call onedark#set_highlight("Macro", { "fg": onedark#GetColors().cyan })
augroup END
