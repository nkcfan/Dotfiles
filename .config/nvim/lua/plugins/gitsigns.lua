local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

return {
    {
        "lewis6991/gitsigns.nvim",
        config = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 500,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
            on_attach = function(bufnr)
                -- Load current file git diff into loclist
                -- TODO: fix the empty list
                -- gitsigns.setqflist(bufnr, { use_location_list = true, open = false})

                -- Actions
                -- map("n", "<LocalLeader>hs", ":Gitsigns stage_hunk<CR>")
                -- map("v", "<LocalLeader>hs", ":Gitsigns stage_hunk<CR>")
                map("n", "<LocalLeader>gu", ":Gitsigns reset_hunk<CR>")
                map("v", "<LocalLeader>gu", ":Gitsigns reset_hunk<CR>")
                -- map("n", "<LocalLeader>hS", "<cmd>Gitsigns stage_buffer<CR>")
                -- map("n", "<LocalLeader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
                -- map("n", "<LocalLeader>hR", "<cmd>Gitsigns reset_buffer<CR>")
                map("n", "<LocalLeader>gd", "<cmd>Gitsigns preview_hunk<CR>")
                -- map("n", "<LocalLeader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
                -- map("n", "<LocalLeader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
                -- map("n", "<LocalLeader>hd", "<cmd>Gitsigns diffthis<CR>")
                -- map("n", "<LocalLeader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
                -- map("n", "<LocalLeader>td", "<cmd>Gitsigns toggle_deleted<CR>")

                -- Text object
                map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
                map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}
