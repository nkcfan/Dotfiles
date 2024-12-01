lazyspec = {
    { "folke/which-key.nvim", config = true },
    { "danilamihailov/beacon.nvim" },
    { "svban/YankAssassin.vim" },
}

-- Source the common vimrc file
-- Note: make sure to set `mapleader` before lazy so your mappings are correct
vim.cmd.source("~/.vimrc")

for plugin, args in pairs(vim.g.PluginSpec_Common) do
    as = {}
    for k, v in pairs(args) do
        if k == 'on' then
            ak = 'cmd'
        elseif k == 'do' then
            ak = 'build'
        else
            ak = k
        end
        as[ak] = v
    end
    table.insert(as, 1, plugin)
    table.insert(lazyspec, as)
end

return lazyspec
