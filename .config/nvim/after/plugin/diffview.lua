require("diffview").setup({
    view = {
        default = {
            layout = "diff2_horizontal"
        }
    },
    keymaps = {
        file_panel = {
            {
                "n", "cc",
                function()
                    vim.ui.input({ prompt = "Commit message: " }, function(msg)
                        if not msg then return end
                        local results = vim.system({ "git", "commit", "-m", msg }, { text = true }):wait()

                        if results.code ~= 0 then
                            vim.notify(
                                "Commit failed with the message: \n"
                                .. vim.trim(results.stdout .. "\n" .. results.stderr),
                                vim.log.levels.ERROR,
                                { title = "Commit" }
                            )
                        else
                            vim.notify(results.stdout, vim.log.levels.INFO, { title = "Commit" })
                        end
                    end)
                end,
            },
            {
                "n", "ca",
                "<Cmd>Git commit --amend <bar> wincmd J<CR>",
                { desc = "Amend the last commit" },
            },
            {
                "n", "c<space>",
                ":Git commit ",
                { desc = "Populate command line with \":Git commit \"" },
            },
        }
    }
})

vim.keymap.set("n", "<leader>gs", ":Git status<CR>");
vim.keymap.set("n", "<leader>dio", ":DiffviewOpen<CR>");
vim.keymap.set("n", "<leader>dih", ":DiffviewHistory %<CR>");
vim.keymap.set("n", "<leader>dic", ":DiffviewClose<CR>");
