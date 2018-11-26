" Fine tune colorscheme
let s:palette = g:lightline#colorscheme#onedark#palette
let s:palette.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:palette.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:palette.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let g:lightline#colorscheme#onedark#palette = lightline#colorscheme#fill(s:palette)
