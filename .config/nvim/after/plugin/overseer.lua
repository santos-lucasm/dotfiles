local overseer = require('overseer').setup()

local mytask_template = {
    name = "Build",
    description = "Build the systemx",
    params = {
        message = {
            type = "string",
            default = "./build.sh",
            description = "Build command"
        },
    },
    condition = {
        -- Optional: Conditions for when this template is available (e.g., based on directory)
        -- dir = vim.fn.getcwd(), -- Only available in the current directory
    },
    builder = function(params)
        -- This must return an overseer.TaskDefinition
        return {
            cmd = { params.message },
            name = "Build",
            cwd = vim.fn.getcwd(),
        }
    end,
}

require('overseer').register_template(mytask_template)

vim.keymap.set("n", "<S-Tab>", ":OverseerToogle<CR>");
vim.keymap.set("n", "<leader>ovb", ":OverseerBuild<CR>");
vim.keymap.set("n", "<leader>ovr", ":OverseerRun<CR>");
