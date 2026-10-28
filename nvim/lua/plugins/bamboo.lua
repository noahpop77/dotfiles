-- Enable the colorscheme
-- Color Scheme is from https://github.com/ribru17/bamboo.nvim
return {
	{
		"ribru17/bamboo.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme bamboo")
			require("bamboo").setup({
				transparent = true,
			})
			require("bamboo").load()

			-- Adds a vertical column denoting character count
			vim.opt.colorcolumn = "80,120"
			vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#525252" })

			-- enforce transparency (bamboo sometimes re-applies bg)
			vim.cmd([[
            highlight Normal guibg=NONE ctermbg=NONE
            highlight NormalNC guibg=NONE ctermbg=NONE
            highlight EndOfBuffer guibg=NONE ctermbg=NONE
            ]])
		end,
	},
}
