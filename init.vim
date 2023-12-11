


lua << EOF
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

EOF


" basic options (easier with vimscript than with lua) "
set nofoldenable
let g:UltiSnipsExpandTrigger = '<tab>' "snippet shortcut"
let g:UltiSnipsSnippetsDir = "~/.nvim/UltiSnips"
let g:vim_markdown_math = 1 "math highlighting in markdown"

" statusline options"
set statusline=\PATH:\ %r%F\ \ \ \ \LINE:\ %l/%L/%P\ TIME:\ %{strftime('%c')}
let timer = timer_start(50, 'UpdateStatusBar',{'repeat':-1})
function! UpdateStatusBar(timer)
  execute 'let &ro = &ro'
endfunction

function MyCustomHighlights()
    hi semshiGlobal ctermfg=green guifg=#ffffff
    hi semshiLocal ctermfg=green guifg=#000000
    hi semshiImported ctermfg=green guifg=#cba9f9
    hi semshiBuiltin ctermfg=green guifg=#cba9f9
endfunction
autocmd FileType python call MyCustomHighlights()
let g:semshi#python#self_call_syn_group = 'Function'

" notes:
" https://github.com/vim-python/python-syntax
" https://github.com/nvim-treesitter/nvim-treesitter
" https://stackoverflow.com/questions/69850464/why-doesnt-neovim-highlight-the-entire-syntax


let g:vimtex_view_method = 'skim'

