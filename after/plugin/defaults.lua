-- Defaults loaded after plugins so they can override plugin-provided settings.
local opt = vim.opt

-- Display and interaction preferences.
opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true

-- Persist undo history and make searches case-aware only when uppercase is used.
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

-- Faster plugin events, a stable sign column, and system clipboard integration.
opt.updatetime = 250
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.hl.on_yank()
  augroup end
]])
