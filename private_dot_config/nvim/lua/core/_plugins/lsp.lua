---
--- lua/core/_plugins/lsp.lua
---
--- Plugin to configure neovim's built-in language server protocol capabilities
---


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function ()

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local home = os.getenv("HOME")

        -- get neovim and nvim_cmp capabilities, set completion for text documents
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.completion = cmp_capabilities.textDocument.completion

        -- get the lua runtime path
        --local lua_runtime_path = vim.split(package.path, ";")

        -- go language server: gopls
        lspconfig.gopls.setup({
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })


        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

    end,

}

