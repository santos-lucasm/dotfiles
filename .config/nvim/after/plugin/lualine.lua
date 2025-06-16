require('lualine').setup {
    options = { theme = 'gruvbox' },
    globalstatus = true,
    tabline = {
        lualine_a = { 'windows' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'searchCount', 'filetype' },
        lualine_y = { '' },
        lualine_z = { '' }
    },
}
