--
-- lua/core/lsp.lua
--
-- LSP configuration for neovim version >= 0.11
--


-- Basic configuration of LSP capabilities and behavior
vim.lsp.config(
  "*",
  {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    root_markers = { ".git" },
  }
)

-- List of active LSPs
vim.lsp.enable({
  "basedpyls",
})

