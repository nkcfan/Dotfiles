local actions = require("telescope.actions")

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
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
