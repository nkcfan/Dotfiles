" Fine tune colorscheme for lightline
let s:palette = g:lightline#colorscheme#onedark#palette
let s:palette.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:palette.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:palette.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let g:lightline#colorscheme#onedark#palette = lightline#colorscheme#fill(s:palette)

" Fine tune colorscheme for hlsearch
call onedark#set_highlight("Search", { "fg": onedark#GetColors().yellow, "bg": onedark#GetColors().comment_grey })
call onedark#set_highlight("IncSearch", { "fg": onedark#GetColors().black, "bg": onedark#GetColors().yellow })
