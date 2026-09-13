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

-- Sync visual selection to * register for middle-click paste
-- Works with which-key/mini.clue and handles large selections efficiently
local timer = nil

local function sync_selection()
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "\22" then
        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        local lines = vim.fn.getregion(start_pos, end_pos, { type = mode })
        vim.fn.setreg("*", table.concat(lines, "\n"))
    end
end

vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Keep * register synced with visual selection (debounced)",
    callback = function()
        local mode = vim.fn.mode()
        if mode == "v" or mode == "V" or mode == "\22" then
            if timer then
                vim.fn.timer_stop(timer)
            end
            -- Sync after 200ms of no cursor movement
            timer = vim.fn.timer_start(200, sync_selection)
        end
    end,
})
