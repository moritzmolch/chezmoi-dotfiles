--
-- lua/core/_plugins/lualine.nvim
--
-- Add stylistic statusbar to neovim
--


return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                component_separators = "|",
                section_separators = "",
            },
        })
    end,
}

