vim.g.mapleader = ' '


vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.textwidth = 100
vim.opt.wrapmargin = 0
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true


vim.opt.clipboard:append("unnamedplus")
vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"

vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum,fuzzy"

vim.o.winbar = "%f"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25



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
})


-- ============================================================
-- KEY BINDS
-- ============================================================
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = "Write file" })
vim.keymap.set('n', '<leader>r', vim.cmd.restart, { desc = "Restart Neovim" })
vim.keymap.set("n", "<leader>f", "<Cmd>Neotree toggle<CR>", { desc = "Neo tree" })

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

vim.api.nvim_create_autocmd("CursorHold", {
    desc = "HighLight variable under cursor ",
    callback = function()
        vim.lsp.buf.document_highlight()
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Clear highLight variable after moved",
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})


-- ============================================================
-- LSP AND TREESITTER CONFIGURATION
-- ============================================================
require("nvim-treesitter").install({ "c", "lua", "vim", "java" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
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



vim.lsp.enable({ 'clangd', 'lua_ls', 'jdtls' })

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

dapui.setup(
-- {
--     layouts = {
--         {
--             position = "left",
--             size = 40,
--             elements = {
--                 {
--                     id = "scopes",
--                     size = 0.50,
--                     title = "Scopes",
--                 },
--                 {
--                     id = "breakpoints",
--                     size = 0.15,
--                     title = "Breakpoints",
--                 },
--                 {
--                     id = "stacks",
--                     size = 0.20,
--                     title = "Call Stack",
--                 },
--                 {
--                     id = "watches",
--                     size = 0.15,
--                     title = "Watches",
--                 },
--             },
--         },
--     },
--     floating = {
--         border = "rounded",
--     },
-- }
)

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
