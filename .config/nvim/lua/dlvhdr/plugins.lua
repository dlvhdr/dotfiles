local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")

-- Have packer use a popup window
packer.init({
  log = { level = "warn" },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use({ "folke/tokyonight.nvim", branch = "main" })
  use("lewis6991/impatient.nvim")

  use("nvim-lua/plenary.nvim")
  use({
    "L3MON4D3/LuaSnip",
    config = "require('dlvhdr.luasnip')",
  })
  use("hrsh7th/nvim-cmp", {
    config = "require('dlvhdr.cmp')",
  })
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("onsails/lspkind-nvim")
  use("nathom/filetype.nvim")
  use({
    "neovim/nvim-lspconfig",
    config = "require('dlvhdr.lsp')",
  })
  use({
    "tami5/lspsaga.nvim",
    config = "require('dlvhdr.lspsaga')",
  })
  use({
    "ray-x/lsp_signature.nvim",
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({ "folke/lua-dev.nvim" })
  use({ "hrsh7th/cmp-emoji", disable = true })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('dlvhdr.treesitter')",
  })

  use("kosayoda/nvim-lightbulb", {
    config = "require('dlvhdr.lightbulb')",
  })

  -- IDE capabilites
  use({
    "nvim-lualine/lualine.nvim",
    config = "require('dlvhdr.lualine')",
  })
  use("folke/trouble.nvim")
  -- use({
  --   "akinsho/toggleterm.nvim",
  --   config = "require('dlvhdr.terminal')",
  -- })
  use({
    "glepnir/dashboard-nvim",
    config = "require('dlvhdr.dashboard')",
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = "require('dlvhdr.gitsigns')",
  })
  use({
    "mfussenegger/nvim-dap",
    config = "require('dlvhdr.dap')",
  })
  use({
    "windwp/nvim-autopairs",
    config = "require('dlvhdr.autopairs')",
  })

  use({
    "j-hui/fidget.nvim",
    config = "require('dlvhdr.fidget')",
  })

  -- Theme
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = "require('dlvhdr.indent-blankline')",
    disable = true,
  })

  -- tpope
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")

  -- Telescope - fzf
  use({
    "nvim-telescope/telescope.nvim",
    config = "require('dlvhdr.telescope')",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  use({
    "norcalli/nvim-colorizer.lua",
    config = "require('dlvhdr.colorizer')",
  })

  use("moll/vim-bbye")

  -- File Explorer
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("dlvhdr.nvim-tree")
    end,
  })

  -- -- auto-session
  -- use({
  --   "rmagatti/auto-session",
  --   config = "require('dlvhdr.auto-session')",
  -- })
  -- use 'rmagatti/session-lens'
  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })

  -- project
  use({
    "ahmedkhalf/project.nvim",
    config = "require('dlvhdr.project')",
    disable = true,
  })

  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = "require('dlvhdr.diffview')",
  })

  use({
    "numToStr/Comment.nvim",
    config = "require('dlvhdr.comment')",
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  })

  -- Other
  use("tpope/vim-surround")
  -- use("mattn/emmet-vim")
  use("christoomey/vim-tmux-navigator")
  use("AndrewRadev/splitjoin.vim")
  use({
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  })

  use({
    "https://github.com/jxnblk/vim-mdx-js",
    ft = { "mdx", "markdown.mdx" },
  })

  use("mg979/vim-visual-multi")

  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({
    "ldelossa/gh.nvim",
    requires = { "ldelossa/litee.nvim" },
    config = "require('dlvhdr.gh-nvim')",
  })

  -- use({
  --   "akinsho/git-conflict.nvim",
  --   config = function()
  --     require("git-conflict").setup()
  --   end,
  -- })

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
