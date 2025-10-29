---
--- lua/core/settings.lua
---
--- Neovim editor settings
---


-------------------------------
-- Display and input options --
-------------------------------


-- Use terminal GUI colors
vim.o.termguicolors = true

-- Enable use of the mouse to navigate
vim.o.mouse = "a"


-------------------------------
-- File settings and backups --
-------------------------------

-- Use UTF-8 encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Update the swap file when there has been no input for 500 ms
vim.o.updatetime = 500

-- Append ins-completion-menu messages to shortmess
-- The option helps to avoid hit-enter prompts caused by file messages
-- TODO Check if this is really needed
vim.o.shortmess = vim.o.shortmess .. "c"


------------------------------------
-- Line numbers and line wrapping --
------------------------------------

-- Wrap text when the displayed line is exhausted
vim.o.wrap = true

-- Do not break inside words
vim.o.linebreak = true

-- Insert linebreaks after 79 characters for text-based filetypes
vim.api.nvim_create_autocmd(
    {"FileType"},
    {
        pattern = {"*.txt", ".md"},
        callback = function ()
            -- Linebreak after 79 characters
            vim.opt_local.textwidth = 79

            -- Enable auto-formatting options
            -- - t: auto-wrap text using 'textwidth'
            -- - c: auto-wrap comments using 'textwidth'; the comment leader is
            --      inserted automatically
            -- - r: Automatically insert current comment leader after hitting
            --      <Enter>
            vim.opt_local.formatoptions = "tcr"
        end,
    }
)

-- Insert an additional sign column (e.g., for git change indicators)
vim.o.signcolumn = "yes"

-- Show current cursor line and column
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Indicate column 80 for linebreak
vim.o.colorcolumn = "80"

-- Show relative line numbers in the right column
vim.o.number = true
vim.o.relativenumber = true

-- Start scrolling 5 lines from the top/bottom
vim.o.scrolloff = 5

-- Show cursor position in the lower right corner
vim.o.ruler = true

--------------------------------
-- Tabulators and indentation --
--------------------------------


-- Expand tabs to spaces
vim.o.expandtab = true

-- Use automatic and smart indentation
vim.o.autoindent = true
vim.o.smartindent = true

-- By default, use a tab width of four spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Use diverging tabwidths for some filetypes
local tab_sizes = {
  lua = 2,
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


------------------------
-- Search and replace --
------------------------

-- Incremental search and match highlighting
vim.o.incsearch = true
vim.o.hlsearch = true

-- Ignore case in general, but smartly decide whether to search case sensitive
-- or insensitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show substitutions in split window
vim.o.inccommand = "split"


--------------------------
-- Text editing helpers --
--------------------------


-- Use english spell checker
vim.o.spelllang = "en_us"

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

-- Characters to highlight tabs, trailing whitespace, and non-breakable
-- space characters
vim.o.listchars = "tab:>~,nbsp:_,trail:."
vim.o.list = true


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

-- show commands as they are typed
vim.o.showcmd = true


----------------------------------
-- Window and buffer management --
----------------------------------

-- When horizontally splitting, the new window is below the current one
vim.o.splitbelow = true

-- When vertically splitting, the new window is right of the current one
vim.o.splitright = true


-------------
-- Keymaps --
-------------


-- Set leader key for commands
vim.keymap.set("", ",", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Create new tabs
vim.keymap.set("n", "<M-t>", ":tabnew<CR>", { noremap = true, silent = true, desc = "Create a new tab" })

-- Move between tabs
vim.keymap.set("n", "<C-t>h", ":tabp<CR>", { noremap = true, silent = true, desc = "Move to the previous tab" })
vim.keymap.set("n", "<C-t>l", ":tabn<CR>", { noremap = true, silent = true, desc = "Move to the next tab" })

-- Move between buffers
vim.keymap.set("n", "<S-h>", ":bp<CR>", { noremap = true, silent = true, desc = "Move to the previous buffer" })
vim.keymap.set("n", "<S-l>", ":bn<CR>", { noremap = true, silent = true, desc = "Move to the next buffer" })

-- Move between split buffers 
vim.keymap.set("n", "<A-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to the split left of the current one" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to the split below the current one" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to the split above the current one" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to the tab right of the current one" })

-- Use arrows to resize splits
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)

-- Use <ESC> to get back to NORMAL mode in terminal emulator
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit TERMINAL mode and go back to NORMAL" })

-- Load telescope functions
local builtin = require('telescope.builtin')

-- Keymaps for different modes of telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true, desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true, desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true, desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true, desc = 'Telescope help tags' })


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

