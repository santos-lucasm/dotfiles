local dapui = require("dapui")
local dap = require("dap")

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
    },
    {
        name = 'Attach to gdbserver :3333',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:3333',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
    },
}


dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

vim.fn.sign_define('DapBreakpoint',
    {
        text = '⚪',
        texthl = 'DapBreakpointSymbol',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
    })

vim.fn.sign_define('DapStopped',
    {
        text = '🔴',
        texthl = 'yellow',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
    })
vim.fn.sign_define('DapBreakpointRejected',
    {
        text = '⭕',
        texthl = 'DapStoppedSymbol',
        linehl = 'DapBreakpoint',
        numhl = 'DapBreakpoint'
    })

dapui.setup({
    expand_lines = true,

    -- Set dapui window
    render = {
        max_type_length = 60,
        max_value_lines = 200,
    },

    --  layouts = {
    --      {
    --          elements = {
    --              { "scopes",  size = 0.5 },
    --              { "stacks",  size = 0.25 },
    --              { "watches", size = 0.25 },
    --          },
    --          size = 25,
    --          position = "left",
    --      },
    --      {
    --          elements = {
    --              { "repl", size = 1 },
    --          },
    --          size = 10,
    --          position = "bottom",
    --      },
    --  },
})

vim.keymap.set('n', '<leader>du', function() dapui.toogle() end, {})
vim.keymap.set({ 'n', 'v' }, '<leader>dw', function() dapui.eval(nil, { enter = true }) end, {})
