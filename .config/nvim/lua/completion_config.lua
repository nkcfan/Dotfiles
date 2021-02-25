vim.g.completion_chain_complete_list = {
    default = {
        {complete_items = {"lsp", "snippet"}},
        {mode = "<c-p>"},
        {mode = "<c-n>"}
    }
}

vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy', 'all'}
vim.g.completion_matching_smart_case = 1
vim.g.completion_auto_change_source = 1
vim.g.completion_trigger_keyword_length = 2
