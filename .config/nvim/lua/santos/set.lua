vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap("n", "<leader><Tab>", ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Tab><Tab>", ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", '<C-w>', { noremap = true, silent = true })

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "120"
