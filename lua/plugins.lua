local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "projekt0n/github-nvim-theme", tag = 'v0.0.7',
      config = function()
        require('github-theme').setup({
            theme_style = "dark",
          })
        end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("plugin_config.alpha").setup()
      end,
    } --]]

    -- Git
    use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin_config.neogit").setup()
      end,
    }

		-- basic Plugins
		use 'jiangmiao/auto-pairs'
		use 'gi1242/vim-tex-autoclose'
		-- Vim Plugins
		use {'lervag/vimtex'}
		-- Snippets
		--use {'sirver/ultisnips'}
		--use({
			--"L3MON4D3/LuaSnip",
			-- follow latest release.
			--tag = "v<CurrentMajor>.*",
			-- install jsregexp (optional!:).
			--run = "make install_jsregexp"
		--})

		use {'sirver/ultisnips'}
		use {'ckunte/latex-snippets-vim'}


		-- general lsp config (language server protocol)
		use {'neovim/nvim-lspconfig'}
    -- Rust config
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim'}
    use {'simrat39/rust-tools.nvim'}

		use {'kyazdani42/nvim-tree.lua'}
		use {'preservim/tagbar'}
		use {'folke/todo-comments.nvim'}
		use {
			"folke/trouble.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("trouble").setup {}
			end
		}
		-- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'

		-- use 'nvim-treesitter/nvim-treesitter'

    -- lua language server
    use {"folke/neodev.nvim"}
		-- python library highlighting
		--use {'numirias/semshi', ft = 'python', run = ':UpdateRemotePlugins',
			--config = function()
				-- vim.g["semshi#excluded_buffers"] = {'*'}
				-- vim.g["semshi#excluded_hl_groups"] = {'local', 'imports'}
			--end
		--}
		-- markdown
		use {'ixru/nvim-markdown'}
		use {'iamcco/markdown-preview.nvim'}

		-- image viewer
		use {'edluffy/hologram.nvim'}


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)

end

return M
