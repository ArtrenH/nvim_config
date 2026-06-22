-- Define short ASCII diagnostic signs for the sign column.
local function sign(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end

sign({ name = "DiagnosticSignError", text = "E" })
sign({ name = "DiagnosticSignWarn", text = "W" })
sign({ name = "DiagnosticSignHint", text = "H" })
sign({ name = "DiagnosticSignInfo", text = "I" })

-- Keep inline diagnostics quiet, but show details on hover via floating windows.
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Open the diagnostic float automatically when the cursor rests on a problem.
vim.cmd([[
  augroup DiagnosticFloat
    autocmd!
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
  augroup end
]])
