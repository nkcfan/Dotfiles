-- ref: https://www.reddit.com/r/neovim/comments/18nx8sj/integrate_nvimtscontextcommentstring/?utm_source=share&utm_medium=web2x&context=3
return {
    {
        "numToStr/Comment.nvim",
        lazy = false,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("Comment").setup({
                pre_hook = function()
                    return vim.bo.commentstring
                end,
            })
        end,
    },
}
