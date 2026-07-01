-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.opt.winborder = "rounded"

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show [d]iagnostic error messages" }) -- Open a floating window to read long errors on the current line
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Open quickfix list

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.o.expandtab = true -- expand tab input with spaces characters
vim.o.smartindent = true -- syntax aware indentations for newline inserts
vim.o.tabstop = 2 -- num of space characters per tab
vim.o.shiftwidth = 2 -- spaces per indentation level

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "wakatime/vim-wakatime", lazy = false },
    { "nvim-mini/mini.nvim", version = "*" },
    { "neovim/nvim-lspconfig" },
    { "stevearc/conform.nvim" },
    { "OXY2DEV/markview.nvim", lazy = false },
    { "folke/which-key.nvim", event = "VeryLazy" },
    {
      "otavioschwanck/arrow.nvim",
      dependencies = {
        { "echasnovski/mini.icons" },
      },
      opts = {
        show_icons = true,
        leader_key = ";",        -- open arrow menu
        buffer_leader_key = "m", -- per-buffer bookmarks
      },
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

vim.g.have_nerd_font = true

-- Arrow keymaps
vim.keymap.set("n", "H", require("arrow.persist").previous, { desc = "Arrow: previous bookmark" })
vim.keymap.set("n", "L", require("arrow.persist").next, { desc = "Arrow: next bookmark" })

-- Icons setup
require("mini.icons").setup()

-- Pick setup
local minipick = require("mini.pick")
minipick.setup()
vim.ui.select = minipick.ui_select

vim.keymap.set("n", "<leader>ff", minipick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", minipick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", minipick.builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", minipick.builtin.help, { desc = "Help tags" })

-- Files setup
local minifiles = require("mini.files")
minifiles.setup({ windows = { preview = true } })

-- Open explorer
vim.keymap.set("n", "<leader>e", minifiles.open, { desc = "Explorer" })

-- Open explorer focused on the current file
vim.keymap.set("n", "<leader>E", function()
  -- Get the absolute path of the current buffer
  local current_file = vim.api.nvim_buf_get_name(0)
  minifiles.open(current_file)
end, { desc = "Explorer (current file)" })

-- Theme setup
vim.cmd.colorscheme("catppuccin")

-- Statusline setup
require("mini.statusline").setup()

-- Starter setup
require("mini.starter").setup()

-- Notify setup
require("mini.notify").setup()

-- Surround setup
require("mini.surround").setup()

-- Diff setup
require("mini.diff").setup({ view = { style = "sign" } })

-- Completion setup
require("mini.completion").setup()

-- LSP setup

vim.diagnostic.config({
  virtual_text = true,
})

-- Recognize vim in lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

-- Get the path to the global typescript installed by mise
local mise_ts_path = vim.fn.trim(vim.fn.system("mise where npm:typescript"))
if mise_ts_path ~= "" then
  vim.lsp.config("ts_ls", {
    init_options = {
      tsserver = {
        -- Point explicitly to the tsserver library
        fallbackPath = mise_ts_path .. "/lib/node_modules/typescript/lib",
      },
    },
  })
end

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

require("lsp")
