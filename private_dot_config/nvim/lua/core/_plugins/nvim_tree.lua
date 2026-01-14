--
-- lua/core/_plugins/nvim_tree.lua
--
-- File explorer for neovim
--


return {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    enabled = false,
    config = function()
        require('nvim-tree').setup({
            hijack_netrw = true,
            disable_netrw = false,
            view = {
                width = 40,
                number = true,
                relativenumber = true,
            },
            git = {
                ignore = false,
            }
        })
    end
}

