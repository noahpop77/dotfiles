return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            window = {
                position = "left",
                width = 25,
            },
            filesystem = {
                filtered_items = {
                    visible = true,           -- ← Forces hidden files to be shown by default
                    hide_dotfiles = false,    -- ← Don't hide files/folders starting with .
                    hide_gitignored = false,
                },
                -- Optional: follow the current file (highlights it in Neo-tree)
                follow_current_file = {
                    enabled = true,
                },
            },
        })

        -- Your original keymap to toggle the sidebar
        vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { silent = true })
    end
}
