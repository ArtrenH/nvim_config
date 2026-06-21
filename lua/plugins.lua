local M = {}

function M.setup()
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
        require("nvim-tree").setup({})
      end,
    },
    "preservim/tagbar",
    "folke/todo-comments.nvim",
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("trouble").setup({})
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
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
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
          return
        end

        configs.setup({
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
