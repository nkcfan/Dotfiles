" Enable italics in Neovim GUI
" Note: Disable italics in terminal because KiTTY + vim one dark will have very dark gray for comment highlight
if has('nvim') && exists('g:GuiLoaded')
    let g:onedark_terminal_italics = 1
endif

augroup colorset
    autocmd!
    " Fine tune colorscheme for hlsearch
    autocmd ColorScheme onedark call onedark#set_highlight("Search", { "fg": onedark#GetColors().yellow, "bg": onedark#GetColors().comment_grey })
    autocmd ColorScheme onedark call onedark#set_highlight("IncSearch", { "fg": onedark#GetColors().black, "bg": onedark#GetColors().yellow })

    " Fine tune colorscheme for syntax highlight
    autocmd ColorScheme onedark call onedark#set_highlight("Macro", { "fg": onedark#GetColors().cyan })
augroup END
