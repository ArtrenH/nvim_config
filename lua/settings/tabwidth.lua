vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt.smarttab = false
		vim.opt.expandtab = false
		vim.opt.preserveindent = false
		vim.opt.copyindent = false
	end
})
