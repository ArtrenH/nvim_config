local M = {}

function M.setup()
  -- Install lazy.nvim automatically when this config is used on a fresh machine.
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Plugin groups are organized by the area of Neovim they configure.
  require("lazy").setup({
    -- UI and navigation
    {
      "projekt0n/github-nvim-theme",
      tag = "v0.0.7",
      config = function()
        require("github-theme").setup({ theme_style = "dark" })
        vim.cmd("colorscheme github_dark")
      end,
    },
    {
      "goolord/alpha-nvim",
      config = function()
        require("plugin_config.alpha").setup()
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- Keep nvim-tree defaults and expose behavior through leader mappings.
        require("nvim-tree").setup({})
      end,
    },
    "preservim/tagbar",
    "folke/todo-comments.nvim",
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- Configure Trouble with defaults for diagnostics/location-list views.
        require("trouble").setup({})
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- Use the active colorscheme and a single statusline across splits.
        require("lualine").setup({
          options = {
            theme = "auto",
            globalstatus = true,
          },
        })
      end,
    },

    -- Git
    {
      "TimUntersberger/neogit",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("plugin_config.neogit").setup()
      end,
    },
    {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Editing, LaTeX, and snippets
    "jiangmiao/auto-pairs",
    "gi1242/vim-tex-autoclose",
    "lervag/vimtex",
    "sirver/ultisnips",
    "ckunte/latex-snippets-vim",

    -- LSP and completion
    { "neovim/nvim-lspconfig" },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",

    -- Syntax and filetype helpers
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      build = ":TSUpdate",
      config = function()
        -- Treesitter may be unavailable immediately after bootstrap; fail softly.
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
          return
        end

        configs.setup({
          -- Only manage parsers used by this config; avoid surprise installs.
          ensure_installed = { "lua", "python", "vim" },
          auto_install = false,
          sync_install = false,
          highlight = { enable = true },
        })
      end,
    },
    {
      "numirias/semshi",
      ft = "python",
      build = ":UpdateRemotePlugins",
    },
    "ixru/nvim-markdown",
    "iamcco/markdown-preview.nvim",
    "edluffy/hologram.nvim",
  })
end

return M
