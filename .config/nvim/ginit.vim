GuiFont! Cascadia Code PL:h11
GuiTabline 0
GuiPopupmenu 0

" Default normal yanks to use the system clipboard
" Note: only in GUI nvim
set clipboard=unnamedplus

" Paste with <Shift> + <Insert>
imap <expr> <S-Insert> XTermPasteBegin("")."<C-R>*<f29>"
cmap <S-Insert> <C-R>*

let $TMP="/tmp"
