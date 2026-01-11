--
-- lua/core/_plugins/luasnip.lua
--
-- Snippet management
--


return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  build = "make install_jsregexp",
  config = function ()
    -- Load snippets from friendly-snippets plugin
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
