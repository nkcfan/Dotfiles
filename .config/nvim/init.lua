local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

lazyspec = {
    { "navarasu/onedark.nvim", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() vim.cmd('colorscheme tokyonight') end },
    { "gbprod/cutlass.nvim" },
    { "folke/which-key.nvim", config = true },
    { "HampusHauffman/block.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-fzy-native.nvim" },
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
    { "neovim/nvim-lspconfig" },
    { "onsails/lspkind-nvim" },
    { "onsails/diaglist.nvim" },
    { "ray-x/lsp_signature.nvim" },
    { "ojroques/nvim-lspfuzzy" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "j-hui/fidget.nvim", tag = "legacy" },
    { "lewis6991/gitsigns.nvim" },
    { "numToStr/Comment.nvim" },
    { "renerocksai/telekasten.nvim" },
    { "danilamihailov/beacon.nvim" },
    { "svban/YankAssassin.vim" },
    { "github/copilot.vim" },
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

    -- For nvim-cmp
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "f3fora/cmp-spell" },
    -- For luasnip users.
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
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

-- Note: do not change rtp in opts. To auto load legacy vimscript plugins,
-- Make a copy of ~/.vim/{after,colors,indent,plugin,syntax} to ~/.config/nvim/.
-- ref: https://github.com/folke/lazy.nvim/discussions/845#discussioncomment-6030168
require("lazy").setup(lazyspec)

vim.cmd.source(vim.fn.stdpath("config") .. "/init.nvim")
