lua require("init")

set nofoldenable
let g:UltiSnipsExpandTrigger = '<tab>'
let g:vim_markdown_math = 1

" Keep semshi's Python highlights readable on the active colorscheme.
function MyCustomHighlights()
    hi semshiGlobal ctermfg=green guifg=#ffffff
    hi semshiLocal ctermfg=green guifg=#000000
    hi semshiImported ctermfg=green guifg=#cba9f9
    hi semshiBuiltin ctermfg=green guifg=#cba9f9
endfunction
autocmd FileType python call MyCustomHighlights()
let g:semshi#python#self_call_syn_group = 'Function'

" Use the native PDF viewer on each supported platform.
if has('macunix')
  let g:vimtex_view_method = 'skim'
elseif has('unix')
  let g:vimtex_view_method = 'zathura'
endif
