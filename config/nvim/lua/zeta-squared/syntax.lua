-- Treesitter Config

-- @deprecated: replace with the commented config at the bottom of
-- this file when migrating to main branch and neovim v0.12.0+
require('nvim-treesitter.configs').setup {
	ensure_installed = {"c", "java", "javascript", "typescript", "tsx", "vim",
		"python", "lua", "html", "json", "jsonc", "css", "scss", "yaml",
        "bash", "go", "make", "dockerfile", "gitignore"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]v"] = "@assignment.lhs",
                ["]of"] = "@function.outer",
                ["]if"] = "@function.inner",
                ["]or"] = "@return.outer",
                ["]ir"] = "@return.inner",
                ["]ob"] = "@block.outer",
                ["]ib"] = "@block.inner",
                ["]os"] = "@call.outer",
                ["]is"] = "@call.inner",
                ["]oc"] = "@conditional.outer",
                ["]ic"] = "@conditional.inner",
                ["]ol"] = "@loop.outer",
                ["]il"] = "@loop.inner",
                ["]z"] = "@fold",
            },
            goto_previous_start = {
                ["[v"] = "@assignment.lhs",
                ["[of"] = "@function.outer",
                ["[if"] = "@function.inner",
                ["[or"] = "@return.outer",
                ["[ir"] = "@return.inner",
                ["[ob"] = "@block.outer",
                ["[ib"] = "@block.inner",
                ["[os"] = "@call.outer",
                ["[is"] = "@call.inner",
                ["[oc"] = "@conditional.outer",
                ["[ic"] = "@conditional.inner",
                ["[ol"] = "@loop.outer",
                ["[il"] = "@loop.inner",
                ["[z"] = "@fold",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["of"] = "@function.outer",
                ["if"] = "@function.inner",
                ["or"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["ob"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["os"] = "@call.outer",
                ["is"] = "@call.inner",
                ["oc"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["ol"] = "@loop.outer",
                ["il"] = "@loop.inner",
                ["z"] = "@fold",
            }
        }
    }
}

local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

-- Repeat movement similar to default vim way with ; (]]) and ,([[)
vim.keymap.set({'n', 'x', 'o'}, ']]', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({'n', 'x', 'o'}, '[[', ts_repeat_move.repeat_last_move_previous)

-- Mini Config
local mini = require('mini.icons')
mini.mock_nvim_web_devicons()

mini.setup({
    extension = {
        js = { glyph = '' },
        cjs = { glyph = '' },
        mjs = { glyph = '' },
        ts = { glyph = '' },
        sass = { glyph = '' },
        scss = { glyph = '' },
        go = { glyph = '' },
        goaccess = { glyph = '' },
        godoc = { glyph = '' },
        gomod = { glyph = '' },
        gosum = { glyph = '' },
        gowork = { glyph = '' },
    }
})

-- Syntax Highlighting Config
local cat_config = require('zeta-squared.cat_config')
require('catppuccin').setup(cat_config)
vim.cmd.colorscheme('catppuccin-macchiato')

-- Folding
vim.wo.foldlevel = 3
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldtext = ''
