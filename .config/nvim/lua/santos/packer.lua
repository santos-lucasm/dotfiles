-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { { 'nvim-lua/plenary.nvim' } } }

    -- Color themes related
    -- use { "xiyaowong/transparent.nvim" } -- transparent on all windows
    -- use { "ellisonleao/gruvbox.nvim" }
    -- use({ "rose-pine/neovim" })
    use { "folke/tokyonight.nvim", config = function() vim.cmd('colorscheme tokyonight-night') end }
    use { "nvim-tree/nvim-web-devicons" }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    -- Add lsp and auto completion support
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- force it to respect clang-format
    use {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
            })
        end,
    }

    -- Git
    use { "tpope/vim-fugitive" }     -- G<everything>
    use { "sindrets/diffview.nvim" } -- DiffOpen
    use { "lewis6991/gitsigns.nvim", config = function() require('gitsigns').setup() end }
    use { 'akinsho/git-conflict.nvim', tag = "*", config = function() require('git-conflict').setup() end }

    -- dap
    use { 'mfussenegger/nvim-dap' }

    -- nvim line
    use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }

    -- quickfix (for live search and replace)
    use { 'stevearc/quicker.nvim', config = function() require('quicker').setup() end }

    -- overseer (run tasks and commands)
    use { 'stevearc/overseer.nvim' }
end)
