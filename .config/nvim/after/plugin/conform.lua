local conform = require('conform')

vim.keymap.set('n', '<space>f', function()
    conform.format { async = true, lsp_fallback = true }
end)
