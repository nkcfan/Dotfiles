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

vim.g.winblend=5
vim.g.pumblend=0

if vim.fn.has('win32') then
    vim.env.TMP = "/tmp"
end

-- highlightedyank
local augroup = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    -- Note: need a lambda for callback to work
    -- ref: https://www.reddit.com/r/neovim/comments/u6ysr5/comment/i5bi1o8/?utm_source=share&utm_medium=web2x&context=3
    callback = function() vim.highlight.on_yank() end,
    group = augroup,
})

if vim.g.started_by_firenvim == true then
    vim.o.guifont = "Hack Nerd Font Mono"
    vim.o.bg = "light"
end
