local function decide_path_minimize()
    if vim.o.columns > 79 then
        return 2
    else
        return 0
    end
end


require('lualine').setup {
    options = { theme = 'tokyonight-night', showtabline = 2 },
    globalstatus = true,
    tabline = {
        lualine_a = { { 'tabs', mode = 2, path = 0, tab_max_length = 60, max_lenght = 120 } },
        lualine_z = { { 'windows', mode = 1, disabled_buftypes = { 'DiffviewFilePanel' } } },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = decide_path_minimize() } },
        lualine_x = { 'searchCount', 'filetype' },
        lualine_y = { 'overseer' },
        lualine_z = { '' }
    },
}
