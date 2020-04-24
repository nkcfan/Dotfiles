" Disable to the indentexpr implementation in ansible-vim plugin, and use
" simple autoindent
setlocal autoindent

function GetAnsibleIndent(lnum)
    return -1
endfunction
