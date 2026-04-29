return {
  "miikanissi/modus-themes.nvim",
  lazy = false,
  priority = 1000,
  config = function ()
    require("modus-themes").setup({
      style = "modus_vivendi", -- Always use modus_operandi regardless of `vim.o.background`
      variants = {
        modus_operandi = "tritanopia", -- Use tritanopia variant for `modus_operandi`
        modus_vivendi = "tritanopia", -- Use tritanopia variant for `modus_vivendi`
      },
      -- styles = {
      --   functions = { italic = true }, -- Enable italics for functions
      -- },
      -- on_colors = function(colors)
      --   colors.error = colors.red_faint -- Change error color to the "faint" variant
      -- end,
      -- on_highlights = function(highlight, color)
      --   highlight.Boolean = { fg = color.green } -- Change Boolean highlight to use the green color
      -- end,
    })
    vim.cmd.colorscheme("modus")
  end,
}
