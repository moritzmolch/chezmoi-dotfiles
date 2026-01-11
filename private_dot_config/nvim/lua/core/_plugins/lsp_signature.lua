--
-- lua/core/_plugins/lsp_signature.lua
--
-- Show function signature during typing
--


return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  },
}

