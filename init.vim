


lua require("init")


" basic options (easier with vimscript than with lua) "
set nofoldenable
let g:UltiSnipsExpandTrigger = '<tab>' "snippet shortcut"
let g:vim_markdown_math = 1 "math highlighting in markdown"

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
