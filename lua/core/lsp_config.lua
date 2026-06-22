-- Mason installs external language servers and exposes them to lspconfig.
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  -- Ensure the primary language servers for this setup are available.
  ensure_installed = {
    "pyright",
    "rust_analyzer",
    "texlab",
  },
  automatic_installation = true,
})

local hover_win
local hover_seq = 0

local function close_hover()
  if hover_win and vim.api.nvim_win_is_valid(hover_win) then
    vim.api.nvim_win_close(hover_win, true)
  end
  hover_win = nil
end

local function trim_empty_lines(lines)
  local first = 1
  while first <= #lines and lines[first] == "" do
    first = first + 1
  end

  local last = #lines
  while last >= first and lines[last] == "" do
    last = last - 1
  end

  return vim.list_slice(lines, first, last)
end

local function hover()
  hover_seq = hover_seq + 1
  local seq = hover_seq

  if hover_win and vim.api.nvim_win_is_valid(hover_win) then
    close_hover()
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_position_params(0, "utf-16")

  vim.lsp.buf_request_all(bufnr, "textDocument/hover", params, function(results)
    if seq ~= hover_seq or not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end

    local lines = {}
    for _, response in pairs(results) do
      local result = response.result
      if result and result.contents then
        vim.list_extend(lines, vim.lsp.util.convert_input_to_markdown_lines(result.contents))
      end
    end

    lines = trim_empty_lines(lines)
    if vim.tbl_isempty(lines) then
      return
    end

    local _, win = vim.lsp.util.open_floating_preview(lines, "markdown", {
      border = "rounded",
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" },
      focusable = false,
      max_height = 20,
      max_width = 80,
    })
    hover_win = win
  end)
end

-- Keymaps that should be available once any LSP client attaches to a buffer.
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", hover, opts)
end

-- Advertise nvim-cmp completion support to every configured language server.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("texlab", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      experimental = {
        -- Recognize custom LaTeX label commands when resolving definitions.
        labelDefinitionCommands = {
          "nllabel",
        },
      },
    },
  },
})

vim.lsp.config("pyright", {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config("emmet_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    -- Enable HTML/CSS abbreviation expansion in markup-heavy filetypes.
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "jinja",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- Generate class names using BEM-style abbreviation support.
        ["bem.enabled"] = true,
      },
    },
  },
})

-- Explicitly start the configured language servers.
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("pyright")
vim.lsp.enable("emmet_ls")
