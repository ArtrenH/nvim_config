require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup {
	ensure_installed = {
		--"bash_language_server",
		--"codelldb",
		--"css_lsp",
		--"html_lsp",
		--"json_lsp",
		--"lua-language-server",
		"pyright",
		"rust_analyzer",
		--"svelte-language-server",
		"texlab",
		--"typescript-language-server",
		--"vim-language-server"
	},
	automatic_installation = true,
}

local on_attach = function(_, _)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	--vim.keymap.set('n', 'gr', require('telescobe.builtin').lsp_refereces, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end


require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach
}

require('lspconfig').texlab.setup {
	on_attach = on_attach
}

require('lspconfig').pyright.setup {
	on_attach = on_attach
}
