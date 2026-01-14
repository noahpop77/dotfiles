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

-- Line numbers on the side of the screen
vim.opt.number = true          -- Show absolute line number on current line
vim.opt.relativenumber = true  -- Show relative numbers on other lines


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("Q", "q<bang>", { bang = true })




