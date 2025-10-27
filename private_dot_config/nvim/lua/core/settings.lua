---
--- lua/core/settings.lua
---
--- Neovim editor settings
---

-------------------------------
-- File settings and backups --
-------------------------------

-- Update the swap file when there has been no input for 500 ms
vim.o.updatetime = 500

-- Append ins-completion-menu messages to shortmess
-- The option helps to avoid hit-enter prompts caused by file messages
-- TODO Check if this is really needed
vim.o.shortmess = vim.o.shortmess .. "c"


------------------------------------
-- Line numbers and line wrapping --
------------------------------------


-- Insert an additional sign column (e.g., for git change indicators)
vim.o.signcolumn = "yes"

-- Show current column of the cursor
vim.o.cursorline = true

-- indicate column 80 (expected 
vim.o.colorcolumn = 80


--------------------------------
-- Tabulators and indentation --
--------------------------------


-- Expand tabs to spaces
vim.o.expandtab = true

-- Use smart indentation
vim.o.smartindent = true

-- By default, use a tab width of four spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Use diverging tabwidths for some filetypes
local tab_sizes = {
  lua = 2,
  tex = 2,
  yaml = 2,
  NvimTree = 2,
}
for file_type, tab_size in pairs(tab_sizes) do
  vim.api.nvim_create_autocmd(
    {"FileType"},
    {
      pattern = file_type,
      callback = function ()
        vim.opt_local.tabstop = tab_size
        vim.opt_local.softtabstop = tab_size
        vim.opt_local.shiftwidth = tab_size
      end,
    }
  )
end


------------
-- Search --
------------


-- Smartly decide whether to search case sensitive or insensitive
vim.o.smartcase = true


--------------------
-- Spell checking --
--------------------


-- Use english spell checker
vim.opt.spelllang = "en_us"

-- Activate spell checker only in text files
vim.api.nvim_create_autocmd(
    {"FileType"},
    {
        pattern = { "*.txt", "*.md" },
        callback = function ()
            vim.opt.spell = true
        end,
    }
)



---------------
-- Clipboard --
---------------

-- set clipboard so that it interfaces with the system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")


------------------------
-- Command minibuffer --
------------------------


-- Command completion settings
-- Pop up completion menu also when there is only exactly one match.
-- Do not select any item before user picks one.
vim.o.completeopt = "menuone,noselect"


-------------
-- Keymaps --
-------------

-- Set leader key for commands
vim.g.mapleader = ","

-- Create new tabs
vim.keymap.set("n", "<M-t>", ":tabnew<CR>", { desc = "Create a new tab" })

-- Switch between tabs
vim.keymap.set("n", "<M-Left>", ":tabp<CR>", { desc = "Move to the tab left of the current one" })
vim.keymap.set("n", "<M-Right>", ":tabn<CR>", { desc = "Move to the tab left of the current one" })

-- Use <ESC> to get back to NORMAL mode in terminal emulator
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit TERMINAL mode and go back to NORMAL" })

-- Load telescope functions
local builtin = require('telescope.builtin')

-- 
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-------------------
-- Miscallaneous --
-------------------


-- Auto-formatting for go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

