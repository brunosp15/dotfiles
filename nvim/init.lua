-- ============================================================
-- Options
-- ============================================================
-- Leader
vim.g.mapleader = ' ' -- Set <Leader> key to Space

-- Editor
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.wrap = false          -- Disable line wrapping
vim.opt.textwidth = 100       -- Preferred maximum line length for formatting
vim.opt.wrapmargin = 0        -- Disable wrap margin
vim.opt.scrolloff = 8         -- Keep 8 lines visible around cursor
vim.opt.cursorline = true     -- Highlight current line

-- Indentation
vim.opt.tabstop = 4        -- Number of spaces a tab displays as
vim.opt.softtabstop = 4    -- Spaces inserted/removed when pressing Tab/Backspace
vim.opt.shiftwidth = 4     -- Spaces used for indentation commands
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart auto-indentation

-- Search
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- Override ignorecase if uppercase is used

-- Windows & Splits
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.laststatus = 3    -- Use a single global statusline
vim.o.winbar = "%f"       -- Show current file name in window bar

-- Command Line
vim.opt.cmdheight = 0                -- Hide command line when not in use
vim.opt.inccommand = "split"         -- Preview substitutions in a split
vim.o.wildmode = "longest:full,full" -- Command-line completion behavior
vim.o.wildoptions = "pum,fuzzy"      -- Popup menu with fuzzy matching

-- Files
vim.opt.swapfile = false                               -- Disable swap files
vim.opt.backup = false                                 -- Disable backup files
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Persistent undo location
vim.opt.undofile = true                                -- Save undo history between sessions

-- UI
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.guicursor = ""     -- Use block cursor in all modes

-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Netrw
vim.g.netrw_banner = 0    -- Hide netrw help banner
vim.g.netrw_liststyle = 3 -- Tree-style directory view
vim.g.netrw_winsize = 25  -- Netrw window width percentage

-- Performance

vim.opt.updatetime = 300 -- Faster CursorHold events (LSP highlights, etc.)


-- ============================================================
-- PLUGINS
-- ============================================================

vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/catppuccin/nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/farmergreg/vim-lastplace",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/jiangmiao/auto-pairs",
    "https://github.com/thehamsta/nvim-dap-virtual-text",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/norcalli/nvim-colorizer.lua",
    "https://github.com/lewis6991/gitsigns.nvim",
})

-- ============================================================
-- LOCAL VARIABLES
-- ============================================================
local dap = require("dap")
local dapui = require("dapui")
local dapWidgets = require("dap.ui.widgets")


-- ============================================================
-- GENERAL PLUGINS CONFIGURATION
-- ============================================================

--  Colorscheme
vim.cmd.colorscheme("moonfly")
-- vim.cmd.colorscheme("catppuccin-nvim")

-- Lua line
require('lualine').setup()

-- Colorizer
require('colorizer').setup()

-- Neo tree
require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    filesystem = {
        follow_current_file = {
            enabled = true,
        }
    },
    event_handlers = {
        {
            event = "file_opened",
            handler = function()
                require("neo-tree.command").execute({
                    action = "close",
                })
            end,
        },
    },
})

-- Blink
require("blink.cmp").setup({
    keymap = {
        preset = "default",
    },
    appearance = {
        nerd_font_variant = "mono",
    },

    completion = {
        menu = {
            border = "rounded",
        },

        trigger = {
            show_on_keyword = true,
        },
        documentation = {
            auto_show = true,

            window = {
                border = "rounded",
            },
        },
    },

    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = {
        implementation = "lua",
    }
})


-- ============================================================
-- KEY BINDS
-- ============================================================
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = "Write file" })
vim.keymap.set('n', '<leader>r', vim.cmd.restart, { desc = "Restart Neovim" })
vim.keymap.set("n", "<leader>t", "<Cmd>Neotree toggle<CR>", { desc = "Neo tree" })

local diag = vim.diagnostic;
local opts = { severity = diag.severity.ERROR }

vim.keymap.set('n', '<leader>e', diag.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set("n", "]e", function() diag.goto_next(opts) end, { desc = "Next error" })
vim.keymap.set("n", "[e", function() diag.goto_prev(opts) end, { desc = "Previous error" })

-- Moving individual lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode " })
vim.keymap.set("i", "kk", "<Esc>", { desc = "Exit insert mode " })

-- Debugger
vim.keymap.set("n", "<F1>", function() dap.toggle_breakpoint() end, { desc = "Debugger toggle breakpoint" })
vim.keymap.set("n", "<F4>", function() dap.terminate() end, { desc = "Debugger terminate" })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debugger continue" })
vim.keymap.set("n", "<F6>", function() dap.pause() end, { desc = "Debugger pause" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debugeer step over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debugeer step into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Debugeer step out" })
vim.keymap.set({ "n", "v" }, "<Leader>dh", function() dapWidgets.hover() end, { desc = "Debugger show hover" })
vim.keymap.set({ "n", "v" }, "<Leader>de", function() dapWidgets.preview() end, { desc = "Debugger preview" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- ============================================================
-- AUTO COMAMNDS
-- ============================================================
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto formating on write",
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false, })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})


-- ============================================================
-- LSP AND TREESITTER CONFIGURATION
-- ============================================================
require("nvim-treesitter").install({ "c", "lua", "vim", "java", "json" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition", buffer = event.buf })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: references", buffer = event.buf })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: hover", buffer = event.buf })
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP: Rename variable", buffer = event.buf })
    end,
})


vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
}
)

vim.lsp.config("jdtls", {
    root_dir = function(_, on_dir)
        on_dir(vim.fn.getcwd())
    end,
    settings = {
        java = {
            project = {
                sourcePaths = {
                    "src/main/java",
                },
            },
        },
    },
})



vim.lsp.enable({ 'clangd', 'lua_ls', 'jdtls', 'jsonls' })

-- ============================================================
-- DEBUGER CONFIGURATION
-- ============================================================

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--quiet" },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            print("Compiling...")
            local result = vim.fn.system("gcc -g chess2.c -o chess -lraylib -lGL -lm -lpthread -ldl -lrt -lX11")
            print(result)
            return vim.fn.getcwd() .. "/chess"
        end,

        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
}

dapui.setup()

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "●", texthl = "DiagnosticError" }
)

vim.fn.sign_define(
    "DapStopped",
    { text = "▶", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
)

require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    virt_text_pos = "eol",
})
