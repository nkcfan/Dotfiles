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

-- Note: do not change rtp in opts. To auto load legacy vimscript plugins,
-- Make a copy of ~/.vim/{after,colors,indent,plugin,syntax} to ~/.config/nvim/.
-- ref: https://github.com/folke/lazy.nvim/discussions/845#discussioncomment-6030168
require("lazy").setup("plugins")
vim.cmd("colorscheme tokyonight")

vim.cmd.source(vim.fn.stdpath("config") .. "/init.nvim")
