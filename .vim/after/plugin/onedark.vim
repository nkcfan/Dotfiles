if has('nvim-0.5.0')
    finish
endif

" Fine tune colorscheme for lightline
if !exists('g:lightline#colorscheme#onedark#palette')
    finish

let s:palette = g:lightline#colorscheme#onedark#palette
let s:palette.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:palette.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:palette.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]

let s:colors = onedark#GetColors()
let s:cursor_grey = s:colors.cursor_grey.cterm
let s:black = s:colors.black.cterm

for key in keys(s:palette)
    let s:value = s:palette[key]
    for subkey in keys(s:value)
        for i in s:value[subkey]
            if len(i) > 3
                if i[3] == s:cursor_grey | let i[3] = '238' | endif
                if i[3] == s:black | let i[3] = '236' | endif
            endif
        endfor
    endfor
    let s:palette[key] = s:value
endfor

let g:lightline#colorscheme#onedark#palette = lightline#colorscheme#fill(s:palette)
