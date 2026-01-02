return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            --- THIS IS WHERE YOU ADD MORE LSPS IF YOU WANT
            ensure_installed = {
                "bashls",
                "clangd",
                "gopls",
                "lua_ls",
                "pyright",
                "zls",
            },
            automatic_enable = true,
        },
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            --- THIS IS WHERE YOU ADD MORE LSPS IF YOU WANT
            vim.lsp.config("bashls", { capabilities = capabilities })
            vim.lsp.config("clangd", { capabilities = capabilities })
            vim.lsp.config("gopls", { capabilities = capabilities })
            -- vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" },},},},})
            vim.lsp.config("pyright", { capabilities = capabilities })
            --- vim.lsp.config("zls", { capabilities = capabilities })
            vim.lsp.config("zls", {
                capabilities = capabilities,
                cmd = { "zls", "--zig-exe-path", "/usr/bin/zig" },
                filetypes = { "zig", "zir" },
                root_dir = require("lspconfig.util").root_pattern("build.zig", "zls.json", ".git"),
            })


            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {version = "LuaJIT"},
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, 'CA', vim.lsp.buf.code_action, {} )
        end,
    },
}
