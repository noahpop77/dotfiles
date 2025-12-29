-- Tab Configuration - Makes it use 4 spaces for a tab instead of default or 8 or whatever
vim.opt.tabstop = 4        -- how many spaces a tab counts for
vim.opt.shiftwidth = 4     -- how many spaces to use for autoindent
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- optional: auto-indent new lines nicely

-- Wraps cursor upon reaching the end
vim.opt.whichwrap:append("<,>,h,l,[,]")

-- Word wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.whichwrap:append("<,>,h,l")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Loads the plugins in the lua/plugins/ directory
require("lazy").setup("plugins")
