return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function ()
    -- Load the ufo lua module
    ufo = require("ufo")

    -- Set key mappings
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)

    -- Set up folding provider
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {"treesitter", "indent"}
      end
    })
  end,
}
