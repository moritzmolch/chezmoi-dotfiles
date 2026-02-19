--
-- lua/core/lsp.lua
--
-- LSP configuration for neovim version >= 0.11
--


--
-- Basic configuration of LSP capabilities and behavior
--

-- Load capabilities from nvim_cmp for auto-completion
cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Base configuration for all language servers
vim.lsp.config(
  "*",
  {
    capabilities = cmp_capabilities,
    root_markers = { ".git" },
  }
)


--
-- Configure rust_analyzer
--

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


--
-- Configure basedpyright
--

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

vim.lsp.config(
  "basedpyright",
  {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
      "pyrightconfig.json",
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    },
    settings = {
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          ignore = {"*"},  -- prefer to use ruff for linting
        },
      },
    },
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
        desc = "Reconfigure basedpyright with the provided python path",
        nargs = 1,
        complete = "file",
      })
    end,
  }
)


--
-- Configure ruff
--

vim.lsp.config(
  "ruff",
  {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = {
      "pyproject.toml",
      "ruff.toml",
      ".ruff.toml",
      ".git",
    },
    settings = {},
  }
)


--
-- Enable LSPs
--


vim.lsp.enable({
  "basedpyright",
  "ruff",
  "rust_analyzer",
})

