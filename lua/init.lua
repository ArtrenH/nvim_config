-- Main Lua entry point loaded from init.vim.

-- Find a Python 3 executable that has pynvim installed for remote plugins.
local function python_with_pynvim()
  local candidates = {
    vim.fn.exepath("python3"),
    "/opt/homebrew/bin/python3",
    "/usr/local/bin/python3",
  }

  for _, py in ipairs(candidates) do
    if py ~= "" and vim.fn.executable(py) == 1 then
      local cmd = { py, "-c", "import pynvim" }
      if vim.fn.system(cmd) and vim.v.shell_error == 0 then
        return py
      end
    end
  end

  return ""
end

-- Pick the first Python executable that can host Neovim remote plugins.
local py = python_with_pynvim()
if py ~= "" then
  vim.g.python3_host_prog = py
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable Space's default motion behavior so it can be used only as leader.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Bootstrap lazy.nvim and register all plugins before loading plugin-backed config.
require("plugins").setup()

-- Core editor behavior and filetype-specific indentation.
require("settings.opts")
require("settings.tabwidth")

-- Language server, completion, and diagnostics configuration.
require("core.lsp_config")
require("core.cmp_config")
require("core.diagnostics_config")

-- Common project navigation and Git shortcuts.
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
vim.keymap.set("n", "<leader>E", function()
  require("nvim-tree.api").tree.toggle_hidden_filter()
end, { desc = "Toggle nvim-tree hidden files" })
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Store custom snippets beside the rest of the Neovim config.
vim.g.UltiSnipsSnippetsDir = vim.fn.stdpath("config") .. "/UltiSnips"

-- Suppress noisy LaTeX reference warnings from vimtex's quickfix list.
vim.g.vimtex_quickfix_ignore_filters = {
  "LaTeX Warning: Reference",
}
