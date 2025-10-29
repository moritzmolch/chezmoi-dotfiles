---
--- init.lua
---
--- Neovim initialization file
---
--- Resources used to create this configuration:
--- - https://github.com/schuam/.dotfiles/blob/main/.config/nvim
--- - https://github.com/weeman1337/ansible-workstation/tree/main/roles/neovim/files/config
---


-- Load module with basic editor settings
require("core.settings")

-- Load plugin configuration
require("core.plugins")

-- Load LSP configuration
require("core.lsp")
