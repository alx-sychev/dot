vim.g.mapleader = " "

-- install plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
    "wbthomason/packer.nvim",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { {'nvim-lua/plenary.nvim'} },
    },
    'neovim/nvim-lspconfig',
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
        "aserowy/tmux.nvim",
        config = function() return require("tmux").setup() end,
    },
    "ellisonleao/gruvbox.nvim",
    "terrortylor/nvim-comment",
})

local telescopeBuiltin = require("telescope.builtin")

-- utils
function kn(...) vim.keymap.set("n", unpack({...})) end
function kv(...) vim.keymap.set("v", unpack({...})) end
function knv(...)
    kn(unpack({...}))
    kv(unpack({...}))
end
function t(command) return "<cmd>Telescope " .. command .. " <CR>" end

-- open vim config
kn("<leader>C", ":e ~/.config/nvim<cr>")

-- buffer navigaion
-- stay on center during navigation
kn("<C-d>", "<C-d>zz")
kn("<C-u>", "<C-u>zz")
kn("n", "nzz")
kn("N", "Nzz")
kn("G", "Gzz")

-- splits
-- create
kn("<leader>v", ':vsp <CR>', { silent = true })
-- navigate
kn("<C-h>", '<C-w>h')
kn("<C-j>", '<C-w>j')
kn("<C-k>", '<C-w>k')
kn("<C-l>", '<C-w>l')
-- resize
kn("<C-A-l>", '<C-w>10>')
kn("<C-A-h>", '<C-w>10<')
kn("<C-A-j>", '<C-w>5+')
kn("<C-A-k>", '<C-w>5-')

-- buffer search
vim.keymap.set('n', '<leader>s', function()
	telescopeBuiltin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
            winblend = 0, -- transparency
            previewer = false,
        }
    )
end)

-- files navigation and search
-- directory view
kn("<leader>fl", telescopeBuiltin.find_files, {})
-- all not ignored files
kn("<leader>ff", telescopeBuiltin.git_files, {})
-- recent files
kn("<leader>fr", telescopeBuiltin.oldfiles, {})
-- grep
kn("<leader>fg", telescopeBuiltin.live_grep, {})
-- edited files
kn("<leader>fe", t("git_status"))
-- open last closed file
kn("<leader><leader>", ':e#\n', { silent = true })

-- autocomplete
local cmp = require "cmp"
cmp.setup {
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
    },

    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
    },

    experimental = {
        ghost_text = true,
    },
}

-- comment
require('nvim_comment').setup()
knv("<leader>/", ":CommentToggle<CR>", { silent = true })

-- lsp
require("lsp")

-- telescope
local telescope = require 'telescope'
telescope.setup {
    defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = { width = 0.8, prompt_position = 'top' }
        },
    },
}

-- vim help
kn("<leader>h", '<cmd>Telescope help_tags<CR>')

-- git
-- gl - git log
kn("<leader>gla", ':Telescope git_commits <CR>')
-- glb - git log for current file
kn("<leader>glf", ':Telescope git_bcommits <CR>')
-- gb - git branch
kn("<leader>gb", ':Telescope git_branches <CR>')

-- colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- opts
vim.opt.nu = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.hlsearch = false
vim.opt.signcolumn = 'no'
vim.opt.termguicolors = true

