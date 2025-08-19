require('lualine').setup {
    options = { theme = 'tokyonight-night' },
    globalstatus = true,
    tabline = {
        lualine_a = { 'windows' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'searchCount', 'filetype' },
        lualine_y = { 'overseer' },
        lualine_z = { '' }
    },
}
