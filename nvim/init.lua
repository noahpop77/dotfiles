-- Tab Configuration
-- Makes it use 4 spaces for a tab instead of default or 8 or whatever
vim.opt.tabstop = 4        -- how many spaces a tab counts for
vim.opt.shiftwidth = 4     -- how many spaces to use for autoindent
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.smartindent = true -- optional: auto-indent new lines nicely

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

require("lazy").setup({
  spec = {
    { 'ribru17/bamboo.nvim', lazy = false, priority = 1000, config = function() require('bamboo').setup{}; require('bamboo').load() end },
    { 'nvim-telescope/telescope.nvim', tag = 'v0.2.0', dependencies = { 'nvim-lua/plenary.nvim' } },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,        -- load immediately
        build = ':TSUpdate', -- run parser update on install/update
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "c", "cpp", "lua", "python", "go" },
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,
    }
    
  },
  install = { colorscheme = { "bamboo" } },
  checker = { enabled = true },
})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-l>', builtin.live_grep, {})

-- Enable the colorscheme
-- Color Scheme is from https://github.com/ribru17/bamboo.nvim
vim.cmd.colorscheme("bamboo")
