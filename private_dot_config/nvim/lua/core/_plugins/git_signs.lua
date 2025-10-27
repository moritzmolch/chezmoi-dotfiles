--
-- lua/core/_plugins/git_signs.lua
--
-- Indicators for changes compared to git HEAD in sign column
--

return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()
    end
}

