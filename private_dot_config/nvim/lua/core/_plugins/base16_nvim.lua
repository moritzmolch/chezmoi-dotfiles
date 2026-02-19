---
--- lua/core/_plugins/base16_nvim.lua
---
--- Plugin that provides a large number of base16 themes
---


return {
    "RRethy/base16-nvim",
    enabled = false,
    lazy = false,
    config = function ()
        require('base16-colorscheme').with_config({
            telescope = true,
            indentblankline = true,
            notify = true,
            ts_rainbow = true,
            cmp = true,
            illuminate = true,
            dapui = true,
        })
        vim.cmd("colorscheme base16-google-dark")
    end,
}
