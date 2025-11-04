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
        stopAtEntry = true,
        setupCommands = {
            text = '-enable-pretty-printing',
            description = 'enable pretty printing',
            ignoreFailures = false
        },
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


require('dapui').setup({
    -- Other dapui configurations...
    layouts = {
        {
            elements = {
                { "scopes",      size = 0.25 },
                { "breakpoints", size = 0.25 },
                { "stacks",      size = 0.25 },
                { "watches",     size = 0.25 },
            },
            size = 0.30,
            position = "left",
        },
        {
            elements = {
                { "repl", size = 1 },
            },
            size = 0.20,
            position = "bottom",
        },
    },
})

-- Open dapui when a debug session launches
dap.listeners.before.launch.dapui_config = function()
    require("dapui").open()
end

-- Close dapui when the debug session terminates or exits
dap.listeners.before.event_terminated.dapui_config = function()
    require("dapui").close()
end

dap.listeners.before.event_exited.dapui_config = function()
    require("dapui").close()
end
