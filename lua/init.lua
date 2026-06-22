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

-- Plugin globals that must be visible to Vimscript-based plugins.
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.vim_markdown_math = 1

-- Use the native PDF viewer on each supported platform.
if vim.fn.has("macunix") == 1 then
  vim.g.vimtex_view_method = "skim"
elseif vim.fn.has("unix") == 1 then
  vim.g.vimtex_view_method = "zathura"
end

local function register_treesitter_compat_directives()
  -- Compatibility for nvim-treesitter markdown injections on this Neovim build.
  vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, source, pred, metadata)
    local capture_id = pred[2]
    local nodes = match[capture_id]
    if type(capture_id) ~= "number" or not nodes or not nodes[1] then
      return
    end

    local info_string = vim.treesitter.get_node_text(nodes[1], source, { metadata = metadata[capture_id] })
    local alias = info_string:match("^%s*([%w_+-]+)")
    if alias then
      metadata["injection.language"] = vim.filetype.match({ filename = "a." .. alias }) or alias
    end
  end, { force = true })
end

register_treesitter_compat_directives()

-- Bootstrap lazy.nvim and register all plugins before loading plugin-backed config.
require("plugins").setup()
register_treesitter_compat_directives()

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
