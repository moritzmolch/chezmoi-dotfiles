--
-- lua/core/lsp.lua
--
-- LSP configuration for neovim version >= 0.11
--

-- Load capabilities from other modules
cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Basic configuration of LSP capabilities and behavior
vim.lsp.config(
  "*",
  {
    capabilities = cmp_capabilities,
    root_markers = { ".git" },
  }
)

-- Configure rust analyzer
vim.lsp.config(
  "rust_analyzer",
  {
    settings = {
      ["rust_analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  }
)


-- List of active LSPs
vim.lsp.enable({
  "basedpyls",
  "rust_analyzer",
})

