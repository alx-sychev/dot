vim.g.mapleader = " "

-- @install plugin manager
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

-- @plugins
require("lazy").setup({
    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",

    -- lsp
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- themes
    "ellisonleao/gruvbox.nvim",

    -- file tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },

    -- phpactor
    {
        "gbprod/phpactor.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required to update phpactor
            "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
        },
    },

    -- other
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { {'nvim-lua/plenary.nvim'} },
    },
    "terrortylor/nvim-comment",
    {
        "aserowy/tmux.nvim",
        config = function() return require("tmux").setup() end,
    },
    "f-person/git-blame.nvim",
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
})

-- @utils
local function kn(...) vim.keymap.set("n", unpack({...})) end
local function kv(...) vim.keymap.set("v", unpack({...})) end
local function knv(...)
    kn(unpack({...}))
    kv(unpack({...}))
end
local function t(command) return "<cmd>Telescope " .. command .. " <CR>" end
local function a(alias, command)
    vim.api.nvim_create_user_command(alias, command, {})
end

-- @open vim config
kn("<leader>C", ":e ~/.config/nvim/init.lua<CR>")

-- @buffer navigaion
-- stay on center during navigation
kn("<C-d>", "<C-d>zz")
kn("<C-u>", "<C-u>zz")
kn("n", "nzz")
kn("N", "Nzz")
kn("G", "Gzz")

-- @splits
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

-- @phpactor
require("phpactor").setup {
    install = {
        bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/bin/phpactor",
    },
}
a("Pnc", "PhpActor new_class")

-- @harpoon
local harpoon = require("harpoon")
harpoon:setup()
kn("<leader>e", function() harpoon:list():append() end)
kn("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
kn("<A-j>", function() harpoon:list():select(1) end)
kn("<A-k>", function() harpoon:list():select(2) end)
kn("<A-l>", function() harpoon:list():select(3) end)
kn("<A-h>", function() harpoon:list():select(4) end)
-- Toggle previous & next buffers stored within Harpoon list
kn("<A-p>", function() harpoon:list():prev() end)
kn("<A-n>", function() harpoon:list():next() end)

-- @buffer search
local buffer_search = function()
	require("telescope.builtin").current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
            winblend = 0, -- transparency
            previewer = false,
        }
    )
end
kn('<leader>S', buffer_search)

-- @netrw
vim.g.netrw_winsize = 70 -- width when open file in vsplit
vim.g.netrw_liststyle = 3 -- tree list style
vim.g.netrw_banner = 0 -- hide banner
vim.g.netrw_localcopydircmd = "cp -r" -- copy dir

-- @file tree
require('neo-tree').setup {
    close_if_last_window = true,
    default_component_configs = {
        last_modified = { enabled = false },
        created = { enabled = false },
        symlink_target = { enabled = true },
    },
    window = {
        width = 35,
        mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
        },
    },
}

-- @files navigation and search
-- directory view
kn("<leader>fd", ":Neotree toggle<cr>", {})
-- all not ignored files
kn("<leader>ff", t("git_files"), {})
-- recent files
kn("<leader>fr", t("oldfiles"), {})
-- grep
kn("<leader>g", t("live_grep"), {})
-- edited files
-- kn("<leader>fe", t("git_status"))
kn("<leader>fe", ":Neotree toggle source=git_status<cr>")
-- open last closed file
kn("<leader><leader>", ':e#\n', { silent = true })

-- @autocomplete
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

-- @comment
require('nvim_comment').setup()
knv("<leader>/", ":CommentToggle<CR>", { silent = true })

-- @lua ls on init
local lua_ls_on_init = function(client)
    local path = client.workspace_folders[1].name

    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT'
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                        -- "${3rd}/luv/library"
                        -- "${3rd}/busted/library",
                    }
                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                    -- library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        })

        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end

    return true
end

-- @lsp on attach
local lsp_on_attach = function(client)
    kn("K", vim.lsp.buf.hover, {buffer=0})

    kn("gr", t("lsp_references"), {buffer=0})
    kn("gd", vim.lsp.buf.definition, {buffer=0})
    kn("gt", vim.lsp.buf.type_definition, {buffer=0})
    kn("gi", vim.lsp.buf.implementation, {buffer=0})

    kn("<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", {buffer=0})
    -- kn("<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", {buffer=0})

    kn("<leader>dn", vim.diagnostic.goto_next, {buffer=0})
    kn("<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
    kn("<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})

    kn("<leader>r", vim.lsp.buf.rename, {buffer=0})
    kn("<leader>a", vim.lsp.buf.code_action, {buffer=0})
end

-- @lsp
require("mason").setup()
require("mason-lspconfig").setup {
    automatic_installation = true,
    ensure_installed = {
        "lua_ls",
        "bashls",
        "phpactor",
        "gopls",
        "pyright",
    }
}
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler
        require("lspconfig")[server_name].setup {
            on_attach = lsp_on_attach,
        }
    end,
    ["lua_ls"] = function ()
        require("lspconfig").lua_ls.setup {
            on_attach = lsp_on_attach,
            on_init = lua_ls_on_init,
        }
    end,
}

-- @telescope
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

-- @help
kn("<leader>h", '<cmd>Telescope help_tags<CR>')

-- @git
-- git blame
require('gitblame').setup {
    enabled = false,
}

-- @colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- @opts
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

