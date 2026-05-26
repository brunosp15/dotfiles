vim.g.mapleader = ' '
vim.g.netrw_banner = 0

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
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

vim.o.autocomplete = true
vim.opt.completeopt = "menu,menuone,noselect,fuzzy"
vim.opt.complete:append('o')

vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.cursorline = true

vim.opt.colorcolumn = "0"
vim.opt.signcolumn = "yes"


vim.o.pumheight = 5
vim.o.pumborder = 'rounded'

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/farmergreg/vim-lastplace",
})

vim.cmd.colorscheme("moonfly")



vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
        end
    end,
})

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>w', vim.cmd.write)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})


vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})


vim.lsp.enable({ 'clangd', 'lua_ls' })
