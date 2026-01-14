--
-- lua/core/_plugins/vimwiki.lua
--
-- Personal documentation wiki
--

return {
    "vimwiki/vimwiki",
    keys = { "<leader>ww", "<leader>wt" },
    init = function ()
        vim.g.vimwiki_list = {
            {
                path = "~/cernbox/vimwiki",
                syntax = "markdown",
                ext = "md",
            },
        }
        -- vim.g.vimwiki_ext2syntax = {  }
        vim.g.vimwiki_global_ext = 0
    end,
}
