local cmp = require("cmp")

-- Some UltiSnips functions are defined lazily; guard calls until they exist.
local function can_call(fn_name)
  return pcall(vim.fn[fn_name])
end

cmp.setup({
  -- nvim-cmp delegates snippet expansion and jumps to UltiSnips.
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    -- Navigate completion candidates without accepting them accidentally.
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      -- Prefer snippet expansion/jump on Tab; otherwise preserve normal Tab.
      local can_expand_or_jump = can_call("UltiSnips#CanExpandSnippet")
        and (vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1)

      if can_expand_or_jump then
        if cmp.visible() then
          cmp.close()
        end

        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(ultisnips_expand_or_jump)", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      -- Shift-Tab moves backward through completion or snippet jump points.
      if cmp.visible() then
        cmp.select_prev_item()
      elseif can_call("UltiSnips#CanJumpBackwards") and vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_backward)", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sources = {
    -- Order sources by usefulness: paths, LSP, signatures, Lua API, buffer text.
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua", keyword_length = 2 },
    { name = "buffer", keyword_length = 2 },
    { name = "calc" },
  },
  window = {
    -- Draw bordered completion and documentation popups for readability.
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    -- Show a compact source marker before each completion item.
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        buffer = "Ω",
        path = "🖫",
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})

-- LaTeX completion is kept narrower to avoid unrelated Lua/signature sources.
cmp.setup.filetype("tex", {
  sources = {
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "buffer", keyword_length = 2 },
    { name = "path" },
  },
})
