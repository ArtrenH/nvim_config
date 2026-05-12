require("plugins").setup()

require("settings.opts")
require('settings.tabwidth')
-- general lsp config
require('core.lsp_config')
-- cmp config
require('core.cmp_config')
require('core.diagnostics_config')

vim.g.vimtex_quickfix_ignore_filters = {
    'LaTeX Warning: Reference',
}

--require("luasnip.loaders.from_snipmate").lazy_load()
