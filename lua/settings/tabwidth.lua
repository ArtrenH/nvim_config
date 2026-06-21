local widths = {
  html = 4,
  markdown = 2,
  tex = 4,
  yml = 2,
}

for filetype, width in pairs(widths) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetype,
    callback = function()
      vim.opt_local.shiftwidth = width
      vim.opt_local.tabstop = width
      vim.opt_local.softtabstop = width
      vim.opt_local.smarttab = false
      vim.opt_local.expandtab = false
      vim.opt_local.preserveindent = false
      vim.opt_local.copyindent = false
    end,
  })
end
