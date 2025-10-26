---
--- lua/core/_plugins/today.lua
---
--- Diary plugin
---

return {
    "VVoruganti/today.nvim",
    config = function ()
        require("today").setup({
	    local_root = "~/git/private/notes",
	})
    end,
}
