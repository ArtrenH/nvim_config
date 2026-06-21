vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.updatetime = 300

-- Fold with Treesitter when a parser is available.
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
