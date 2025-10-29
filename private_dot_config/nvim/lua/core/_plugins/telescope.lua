---
--- lua/core/_plugins/telescope.lua
---
--- Plugin to integrate telescope interface into neovim
---


return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-lua/popup.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim' },
        {
            'nvim-telescope/telescope-live-grep-args.nvim',
            version = '^1.0.0',
        },
    },
    config = function ()
        -- Load the telescope modules used in this configuration
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local lga_actions = require('telescope-live-grep-args.actions')

        -- Set up telescope actions
        telescope.setup({
            defaults = {
                path_display = { 'truncate' },
                mappings = {
                    i = {
                        ['<CR>'] = actions.select_default + actions.center,
                    },
                    n = {
                        ['<CR>'] = actions.select_default + actions.center,
                    },
                },
            },
            extensions = {
                live_grep_args = {
                    mappings = {
                        i = {
                            ['<C-k>'] = lga_actions.quote_prompt(),
                        },
                    },
                },
            },
        })

        -- Load live grep and fzf extensions
        telescope.load_extension('live_grep_args')
        telescope.load_extension('fzf')

	-- Keymaps for different modes of telescope
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true, desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true, desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true, desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true, desc = 'Telescope help tags' })
    end,
}
