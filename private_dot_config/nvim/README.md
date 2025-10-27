# neovim configuration

Configuration files for `neovim`.


## Old `etp-thinkpad-l14` configuration

The configuration of some plugins from the old `etp-thinkpad-l14` configuration
is still missing.

**TODO:** Check if it these plugins/plugin configuration need to be included
into the central configuration.

```lua

  -- set automatic bracket pairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  -- auto-completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'rasulomaroff/cmp-bufname',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        completion = {
          completeopt = 'menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          })
        }),
        sources = {
          {
            name = 'nvim_lsp',
          },
          {
            name = 'buffer',
            keyword_length = 3,
            option = {
              get_bufnrs = function()
                local buffers = vim.api.nvim_list_bufs()
                local retbufs = {}

                for key, bufno in pairs(buffers) do
                  local bufname = vim.api.nvim_buf_get_name(bufno)

                  if string.find(bufname, 'NvimTree') then goto skip_buf end

                  -- skip files larger than 1 MiB
                  local byte_size = vim.api.nvim_buf_get_offset(bufno, vim.api.nvim_buf_line_count(bufno))
                  if byte_size > 1024 * 1024 then goto skip_buf end

                  table.insert(retbufs, bufno)

                  ::skip_buf::
                end

                return retbufs
              end
            }
          },
          {
            name = 'bufname'
          },
          {
            name = 'path',
          },
          {
            name = 'nvim_lsp_signature_help',
          },
        }
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  },

  -- configuration of language server protocol in neovim
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
    },
    config = function()
      require('neodev').setup()

      local lspconfig = require('lspconfig')

      -- generate neovim client and auto-completion capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion = cmp_capabilities.textDocument.completion

      -- Python
      lspconfig.pylsp.setup({ capabilities = capabilities })

      -- LaTeX
      lspconfig.texlab.setup({ capabilities = capabilities })

      -- YAML
      lspconfig.yamlls.setup({ capabilities = capabilities })

      -- docker
      lspconfig.dockerls.setup({ capabilities = capabilities })

    end,
  },



  -- pandoc
  {
    "aspeddro/pandoc.nvim",
    config = function()
      pandoc = require("pandoc")
      pandoc.setup()
    end,
  },

  -- vimtex
  {
    "lervag/vimtex",
    lazy = false,
    init = function ()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },

  -- luasnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- load vscode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- optional: keymaps
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          return "<Tab>"
        end
      end, { expr = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { expr = true })
    end,
  }

```
