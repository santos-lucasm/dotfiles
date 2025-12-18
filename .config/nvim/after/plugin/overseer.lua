local overseer = require('overseer').setup({
    task_list = {
        direction = "bottom",
        open_on_start = true,
    },
    -- Configure components for tasks
    components = {
        -- ... other components
        "open_output", -- Ensure this component is loaded
    },
    -- Configuration for the open_output component
    open_output = {
        -- Options: 'always', 'if_no_on_output_quickfix', 'never'
        on_start = "always",
        -- Options: 'dock', 'vsplit', 'hsplit', 'float', 'pedit', 'tab'
        direction = "dock",
    },
})

vim.keymap.set("n", "<S-Tab>", ":OverseerToggle<CR>");
vim.keymap.set("n", "<leader>ovs", ":OverseerShell<CR>");
vim.keymap.set("n", "<leader>ovr", ":OverseerRun<CR>");
