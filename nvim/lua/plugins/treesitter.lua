return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,          -- load immediately
    build = ':TSUpdate',   -- run parser update on install/update
    config = function()
        -- Safe require so it doesn’t fail if plugin isn’t installed yet
        local ok, ts = pcall(require, 'nvim-treesitter.configs')
        if not ok then
            vim.notify("nvim-treesitter not installed yet!", vim.log.levels.WARN)
            return
        end

        ts.setup({
            --- ensure_installed = { "lua", "c", "cpp", "go", "python" },
            auto_install = true, --- Auto installs when we open a file it doesnt have an LSP for 
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
