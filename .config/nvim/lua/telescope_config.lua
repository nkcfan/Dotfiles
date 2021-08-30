require("telescope").setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        layout_config = {
            prompt_position = "top",
        },
        sorting_strategy = "ascending",
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')
