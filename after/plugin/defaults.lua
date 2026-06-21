local opt = vim.opt

opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
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
