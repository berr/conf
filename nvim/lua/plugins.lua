local h = require('vim-helpers');

local function colorscheme_config()
    vim.cmd.colorscheme("kanagawa-dragon")
end


local function lua_line_config()
    local l = require('lualine');
    l.setup({
        options = { theme = 'auto' },
    });
end

local function neo_tree_config()
    local neo_tree = require('neo-tree.command');
    local global_position = 'left';

    local function toggle()
        neo_tree.execute(
            { action = 'show', position = global_position, toggle = true })
    end
    local function focus()
        neo_tree.execute(
            { action = 'focus', position = global_position, toggle = false })
    end
    local function close()
        neo_tree.execute(
            { action = 'close', position = global_position, toggle = false })
    end
    local wk = require("which-key")
    wk.add({
        { "<leader>t",  group = "Tree", },
        { "<leader>tt", toggle,         desc = "Toggle" },
        { "<leader>tf", focus,          desc = "Focus" },
        { "<leader>tc", close,          desc = "Close" }
    });
end

local function tree_sitter_config()
    require('nvim-treesitter.configs').setup({
        sync_install = false,
        auto_install = false,

        ignore_install = {},

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enable = true
        },

        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "json",
            "lua",
            "just",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "rust",
            "cpp",
            "nix",
        },
    })
end

local function tree_sitter_textobjects_config()
    require("nvim-treesitter-textobjects").setup {
        select = {
            lookahead = true,
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
        },
        move = {
            set_jumps = true,
        }
    }
    local tos = require("nvim-treesitter-textobjects.select");
    local tom = require("nvim-treesitter-textobjects.move");
    local wk = require("which-key")
    wk.add({
        { "<leader>cs",  desc = "Select through tree sitter",                                                 group = "Select", },
        { "<leader>csf", function() tos.select_textobject("@function.outer", "textobjects") end,              desc = "Select outer function" },
        { "<leader>csF", function() tos.select_textobject("@function.inner", "textobjects") end,              desc = "Select inner function" },
        { "<leader>csc", function() tos.select_textobject("@class.outer", "textobjects") end,                 desc = "Select outer class" },
        { "<leader>csC", function() tos.select_textobject("@class.inner", "textobjects") end,                 desc = "Select inner class" },
        { "<leader>csl", function() tos.select_textobject("@class.scope", "locals") end,                      desc = "Select locals" },

        { "<leader>gfs", function() tom.goto_next_start("@function.outer", "textobjects") end,                desc = "Move to next function start" },
        { "<leader>gfe", function() tom.goto_next_end("@function.outer", "textobjects") end,                  desc = "Move to next function end" },
        { "<leader>gFs", function() tom.goto_previous_start("@function.outer", "textobjects") end,            desc = "Move to previous function start" },
        { "<leader>gFe", function() tom.goto_previous_end("@function.outer", "textobjects") end,              desc = "Move to previous function end" },

        { "<leader>gcs", function() tom.goto_next_start("@class.outer", "textobjects") end,                   desc = "Move to next class start" },
        { "<leader>gce", function() tom.goto_next_end("@class.outer", "textobjects") end,                     desc = "Move to next class end" },
        { "<leader>gCe", function() tom.goto_previous_start("@class.outer", "textobjects") end,               desc = "Move to previous class start" },
        { "<leader>gCe", function() tom.goto_previous_end("@class.outer", "textobjects") end,                 desc = "Move to previous class end" },

        { "<leader>gL",  function() tom.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects") end, desc = "Move to next loop start/finish" },
        { "<leader>gl",  function() tom.goto_next_start("@local.scope", "locals") end,                        desc = "Move to next local" },
        { "<leader>gn",  function() tom.goto_next_start("@fold", "folds") end,                                desc = "Move to next fold" },
        { "Tab",         function() tom.repeat_last_move_nex() end,                                           desc = "Repeat last foward move" },
        { "<C-Tab>",     function() tom.repeat_last_move_previous() end,                                      desc = "Repeat last backward move" },

    });
end


local function lsp_config()
    local lspconfig = require("lspconfig")

    vim.lsp.enable('lua_ls');
    vim.lsp.enable('pyright');
    -- rust is configured through rustaceanvim

    vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle line comment" });
    vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle selection comment" });

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local opts = { buffer = ev.buf };



            local builtin = require('telescope.builtin')


            local wk = require("which-key")
            wk.add({
                { "<leader>c",  desc = "Code actions",                                group = "Code", },
                { "<leader>ch", vim.lsp.buf.hover,                                    desc = "Hover" },
                { "<leader>cS", vim.lsp.buf.signature_help,                           desc = "Display signature" },
                { "<leader>ca", vim.lsp.buf.code_action,                              desc = "Code action" },
                { "<leader>cr", vim.lsp.buf.rename,                                   desc = "Rename" },
                { "<leader>cf", vim.lsp.buf.format,                                   desc = "Format file" },
                { "<leader>cc", function() vim.cmd.RustLsp { 'flyCheck', 'run' } end, desc = "Format file" },

                { "g",          group = "Move cursor", },
                { "gs",         builtin.lsp_document_symbols,                         desc = "List Symbols" },
                { "gS",         builtin.lsp_workspace_symbols,                        desc = "List sybools in workspace" },
                { "gr",         builtin.lsp_references,                               desc = "List references to this symbol" },
                { "gi",         builtin.lsp_incoming_calls,                           desc = "List incoming calls" },
                { "go",         builtin.lsp_outgoing_calls,                           desc = "List outgoing calls" },
                { "gI",         builtin.lsp_implementations,                          desc = "List implementations" },
                { "gd",         builtin.lsp_definitions,                              desc = "List definitions" },
                { "gt",         builtin.lsp_type_definitions,                         desc = "List type definitions" },
            });
        end
    });
end

local function rust_config()
end

local function telescope_config()
    local builtin = require('telescope.builtin')
    local wk = require("which-key")
    wk.add({
        { "gb", desc = "Buffers",    cmd = builtin.find_files },
        { "g?", desc = "Help Tags",  cmd = builtin.help_tags },
        { "gm", desc = "Marks",      cmd = builtin.marks },
        { "gj", desc = "Jumplist",   cmd = builtin.jumplist },
        { "gR", desc = "Registers",  cmd = builtin.registers },
        { "gh", desc = "Highlights", cmd = builtin.highlights },
    })
end

local function neotest_config()
    require('neotest').setup {
        adapters = {
            require('rustaceanvim.neotest')
        },
    }

    local wk = require("which-key")
    wk.add({
        { "<leader>cT", function() vim.cmd.Neotest { 'summary' } end, desc = "List found tests" },
    })
end


require("lazy-bootstrap").setup({
    {
        "rebelot/kanagawa.nvim",
        config = colorscheme_config,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = lua_line_config,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons"
        },
        lazy = false,
        config = neo_tree_config
    },
    {
        "mason-org/mason.nvim",
        opts = {},
        dependencies = {},
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = lsp_config,
        opts = {
            inlay_hints = { enabled = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        lazy = false,
        config = tree_sitter_config,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^8',
        lazy = false,
        init = rust_config,
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = telescope_config,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = tree_sitter_textobjects_config
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'enter' },
            appearance = {
                nerd_font_variant = 'mono'
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "kylechui/nvim-surround",
        version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = neotest_config,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>ed",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>eD",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>es",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>el",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>eL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>eQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        'MagicDuck/grug-far.nvim',
        -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
        -- additional lazy config to defer loading is not really needed...
        config = function()
            -- optional setup call to override plugin options
            -- alternatively you can set options with vim.g.grug_far = { ... }
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
            });
        end
    },
})

local function which_key_config()
    local builtin = require('telescope.builtin')
    local wk = require("which-key");
    wk.add({
        { "<leader>f",   group = "File" },
        { "<leader>ff",  builtin.find_files,                                                               desc = "Find file by name" },
        { "<leader>fg",  builtin.live_grep,                                                                desc = "Find file by content" },
        { "<leader>fs",  ":w<CR>",                                                                         desc = "Save" },
        { "<leader>fr",  ":edit!<CR>",                                                                     desc = "Reload" },
        { "<leader>fE",  group = "Line ending" },
        { "<leader>fEw", ":w ++ff=dos<CR>",                                                                desc = "Save in DOS line ending" },
        { "<leader>fEu", ":w ++ff=unix<CR>",                                                               desc = "Save in Unix line ending" },
        { "<leader>fEm", ":w ++ff=mac<CR>",                                                                desc = "Save in Mac line ending" },
        { "<leader>w",   proxy = "<c-w>",                                                                  group = "Windows" },
        { "<leader>di",  h.toggle_inlay_hints,                                                             desc = "Toggle display of inlay hints" },
        { "<leader>dl",  h.toggle_line_numbers,                                                            desc = "Toggle display of line numbers" },
        { "<leader>dL",  h.toggle_relative_line_numbers,                                                   desc = "Toggle display of relative line numbers" },
        { "<leader>dw",  h.toggle_whitespace,                                                              desc = "Toggle display of whitespaces" },
        { "<leader>dh",  ":nohl<CR>",                                                                      desc = "Hide highlights" },
        { "<leader>s",   function() require('grug-far').open({ visualSelectionUsage = 'auto-detect' }) end, desc = "Search/Replace" },
    });
end


which_key_config()
