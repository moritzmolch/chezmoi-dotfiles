---
--- lua/core/_plugins/which_key.lua
---
--- Plugin which provides information about keymaps during typing
---


return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function ()
                require("which-key").show({ global = true })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        }
    }
}
