-- This function gets run when an LSP attaches to a particular buffer.
-- That is to say, every time a new file is opened that is associated with
-- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
-- function will be executed to configure the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        -- We create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us
        -- each time.
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local fzflua = require('fzf-lua')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable or function was first defined, etc.
        --  To jump back, press <C-T>.
        map('grd', fzflua.lsp_definitions, '[G]oto [D]efitinion')

        -- This is not goto definition.
        --  For example, in C this would take you to the header.
        map('grD', fzflua.lsp_declarations, '[G]oto [D]eclaration')

        -- Find references for the word under your cursor.
        map('grr', fzflua.lsp_references, '[G]oto [R]eferences')
    end
})

-- Lazydev lua_ls configuration
require('lazydev').setup({
    library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
})

local servers = {
    ['python-lsp-server'] = {
        lsp = 'pylsp',
        config = {},
    },
    ['lua-language-server'] = {
        lsp = 'lua_ls',
        config = {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = 'Replace',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        },
    },
    texlab = {
        lsp = 'texlab',
        config = {},
    },
    ['typescript-language-server'] = {
        lsp = 'ts_ls',
        config = {
            init_options = {
                preferences = {
                    quotePreference = 'single',
                },
            },
        },
    },
    ['yaml-language-server'] = {
        lsp = 'yamlls',
        config = {},
    },
    ['gopls'] = {
        lsp = 'gopls',
        config = {},
    },
    ['eslint-lsp'] = {
        lsp = 'eslint',
        config = {
            settings = {
                workingDirectory = { mode = 'auto' },
            },
        },
    },
}

require('mason').setup({})

require('mason-tool-installer').setup({
    ensure_installed  = vim.list_extend(vim.tbl_keys(servers or {}), {
        'debugpy',
        'js-debug-adapter',
        'chrome-debug-adapter',
    })
})

for _, settings in pairs(servers) do
    if settings.lsp == 'eslint' then
        local base_on_attach = vim.lsp.config.eslint.on_attach
        vim.lsp.config('eslint', {
            on_attach = function(client, bufnr)
                if not base_on_attach then return end

                base_on_attach(client, bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    command = 'LspEslintFixAll',
                })
            end,
            settings = {
                workingDirectory = { mode = 'auto' },
            },
        })
        vim.lsp.enable('eslint')
    else
        vim.lsp.config(settings.lsp, settings.config)
        vim.lsp.enable(settings.lsp)
    end
end

-- Diagnostic Config
vim.diagnostic.config({
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
    } or {},
    virtual_text = true,
})
