-- return {
-- 	--- {}
-- 	"nvimtools/none-ls.nvim",
-- 	config = function()
--
-- 		local null_ls = require("null-ls")
-- 		null_ls.setup({
-- 			sources = {
-- 				null_ls.builtins.formatting.stylua,     -- Lua formatter
--                 null_ls.builtins.formatting.black,      -- Python formatter
--                 null_ls.builtins.formatting.isort,      -- Python import sorter 
--                 null_ls.builtins.formatting.gofumpt,    -- Go formatter
--                 null_ls.builtins.formatting.goimports,  -- Go import managements
--                 null_ls.builtins.diagnostics.cpplint,   -- C/C++ Linter
--                 null_ls.builtins.formatting.clang_format,   -- C/C++ Formatter
-- 			},
-- 		})
--
--
-- 		vim.keymap.set("n", "GF", vim.lsp.buf.format, {})
-- 	end,
-- }


return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local helpers = require("null-ls.helpers")

        local cpplint = {
            name = "cpplint",
            method = null_ls.methods.DIAGNOSTICS,
            filetypes = { "c", "cpp" },

            generator = null_ls.generator({
                command = "/home/sawa/.local/bin/cpplint",
                args = { "--output=vs7", "-" },
                to_stdin = true,
                from_stderr = true,
                format = "line",

                on_output = helpers.diagnostics.from_patterns({
                    {
                        pattern = [[:(%d+):(%d+): (%w+): (.*)]],
                        groups = { "row", "col", "code", "message" },
                    },
                }),
            }),
        }

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.goimports,

                cpplint,

                null_ls.builtins.formatting.clang_format,
            },
        })

        vim.keymap.set("n", "GF", vim.lsp.buf.format, {})
    end,
}
