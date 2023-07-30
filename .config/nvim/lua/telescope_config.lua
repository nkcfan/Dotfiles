local actions = require("telescope.actions")

local find_command = { vim.env.FZF_DEFAULT_COMMAND or vim.fn.expand('~/bin/ripgrep_git.cmd') }

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<C-H>"] = "which_key",
                ["<Esc>"] = actions.close
            }
        },
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        layout_config = {
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
    },
    pickers = {
        find_files = {
            find_command = find_command,
        },
        live_grep = {
            find_command = find_command,
        },
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')

vim.api.nvim_set_keymap('n', 'z=', '<cmd>Telescope spell_suggest<CR>', {})
vim.api.nvim_set_keymap('n', '<C-S-PageDown>', '<cmd>Telescope loclist<CR>', {})
vim.api.nvim_set_keymap('n', '<S-PageDown>', '<cmd>Telescope quickfix<CR>', {})
vim.api.nvim_set_keymap('n', '<M-p>', '<cmd>Telescope buffers<CR>', {})
