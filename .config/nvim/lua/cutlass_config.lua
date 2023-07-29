require("cutlass").setup({
    cut_key = 'm',
    override_del = true,
    exclude = {},
    registers = {
        select = "_",
        delete = "_",
        change = "_",
    },
})
