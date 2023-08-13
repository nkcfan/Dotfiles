lazyspec = {
    { "folke/which-key.nvim", config = true },
    { "nvim-lua/popup.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- We recommend updating the parsers on update
    { "nvim-treesitter/nvim-treesitter-refactor" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "williamboman/mason.nvim", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = true,
    },
    { "numToStr/Comment.nvim", config = true },
    { "danilamihailov/beacon.nvim" },
    { "svban/YankAssassin.vim" },
    {
        "glacambre/firenvim",

        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        cond = not not vim.g.started_by_firenvim,
        build = function()
            require("lazy").load({ plugins = "firenvim", wait = true })
            vim.fn["firenvim#install"](0)
        end,
    },
}

-- Source the common vimrc file
-- Note: make sure to set `mapleader` before lazy so your mappings are correct
vim.cmd.source("~/.vimrc")

for plugin, args in pairs(vim.g.PluginSpec_Common) do
    if args.on then
        args.cmd = args.on
        args.on = nil
    end
    if args["do"] then
        args.build = args["do"]
        args["do"] = nil
    end
    table.insert(args, 1, plugin)
    table.insert(lazyspec, args)
end

return lazyspec
