return {
    "mason-org/mason.nvim",
    config = function()
        require("mason").setup()
    end,
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}
