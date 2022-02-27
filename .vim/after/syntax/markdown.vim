setlocal conceallevel=2

let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal_code_blocks = 0 " in favor of pandoc conceal

" Disable diagnostic virtual_text with markdown file type
lua vim.diagnostic.config({virtual_text = false})
