--
-- lua/core/_plugins/dotenv_nvim.lua
--
-- Load environment from '.env' file
--


return {
  "ellisonleao/dotenv.nvim",
  config = function ()
    -- Set up the plugin
    require('dotenv').setup({
      enable_on_load = false,
      verbose = false,
    })

    -- Define keymap to load the environment
    vim.keymap.set("n", "<leader>le", ":Dotenv", { noremap = true, silent = true, desc = "Load environment from local '.env' file" })
  end,
}
