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
  ensure_installed = {
    "pyright",
    "rust_analyzer",
    "texlab",
  },
  automatic_installation = true,
})

local on_attach = function(_, _)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end

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
        ["bem.enabled"] = true,
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("texlab")
vim.lsp.enable("pyright")
vim.lsp.enable("emmet_ls")
