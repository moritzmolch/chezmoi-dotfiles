---
--- lua/core/_plugins/lsp.lua
---
--- Treesitter plugin for improved syntax tree parsing
---


return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    lazy = false,
    build = ":TSUpdate",
    config = function ()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "comment",
                "cpp",
                "css",
                "csv",
                "desktop",
                "dockerfile",
                "diff",
                "dot",
                "doxygen",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "goctl",
                "gomod",
                "gosum",
                "gotmpl",
                "gowork",
                "html",
                "htmldjango",
                "json",
                "latex",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "mermaid",
                "nginx",
                "passwd",
                "php",
                "php_only",
                "phpdoc",
                "python",
                "regex",
                "scss",
                "snakemake",
                "toml",
                "vim",
                "vimdoc",
                "xml",
                "xresources",
                "yaml",
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                disable = {},
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    },
                },
            },
        })
    end,
}
