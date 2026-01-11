---
--- lua/core/_plugins/nvim_cmp.lua
---
--- Plugin for auto-completion
---


return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
    },
    config = function ()
        -- load the lua cmp source
        cmp = require("cmp")

        -- load lspkind module for adding icons to suggestions
        lspkind = require("lspkind")

        -- load luasnip
        local luasnip = require("luasnip")

        -- basic cmp setup
        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            snippet = {
              expand = function(args)
                luasnip.lsp_expand(args.body)
              end,
            },
            sources = cmp.config.sources({
                { name = "path" },
                { name = "buffer" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }),
            formatting = {
              format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = {
                  menu = 50,
                  abbr = 50,
                },
                ellipsis_char = "...",
                show_labelDetails = true,
              }),
            },
        })

        -- setup auto-completion for command line in search mode (/)
        cmp.setup.cmdline(
            { "/", "?" },
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            }
        )

         -- setup auto-completion for command line in command mode (/)
        cmp.setup.cmdline(
            ":",
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { 
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },  -- ignore the manpage and the ! commands for auto-completion
                        },
                    },
                }),
            }
        )

        -- lsp setup


    end,
}
