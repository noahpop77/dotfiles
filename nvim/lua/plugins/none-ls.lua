return {
	--- {}
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,     -- Lua formatter
                null_ls.builtins.formatting.black,      -- Python formatter
                null_ls.builtins.formatting.isort,      -- Python import sorter 
                null_ls.builtins.formatting.gofumpt,    -- Go formatter
                null_ls.builtins.formatting.goimports,  -- Go import managements
                null_ls.builtins.diagnostics.cpplint,   -- C/C++ Linter
                null_ls.builtins.formatting.clang_format,   -- C/C++ Formatter
			},
		})

		vim.keymap.set("n", "GF", vim.lsp.buf.format, {})
	end,
}
