require("plugins").setup()

require("settings.opts")
require('settings.tabwidth')
-- general lsp config
require('core.lsp_config')
-- cmp config
require('core.cmp_config')
require('core.diagnostics_config')

--require("luasnip.loaders.from_snipmate").lazy_load()

-- Treesitter Plugin Setup 
--[[ require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
} -- ]]

