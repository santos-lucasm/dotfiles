local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>po', builtin.lsp_document_symbols, {})

-- grep in whole directory
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- list buffers
vim.keymap.set('n', '<leader>b', function()
    builtin.buffers({
        initial_mode = "normal",
        attach_mappings = function(_, map)
            map('n', 'j', actions.move_selection_next)
            map('n', 'k', actions.move_selection_previous)
            map('n', '<C-d>', actions.delete_buffer)
            map('n', 'dd', actions.delete_buffer)
            return true
        end
    })
end, {})
