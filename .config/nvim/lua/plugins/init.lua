lazyspec = {
    { "folke/which-key.nvim", config = true },
    { "williamboman/mason.nvim", config = true },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = true,
    },
    { "danilamihailov/beacon.nvim" },
    { "svban/YankAssassin.vim" },
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
