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
  print("Installing packer. When done, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
local packer_util = require("packer.util")

-- Have packer use a popup window
packer.init({
  log = { level = "warn" },
  display = {
    open_fn = function()
      return packer_util.float({ border = "rounded" })
    end,
  },
  snapshot_path = packer_util.join_paths(vim.fn.stdpath("config"), "packer_snapshots"),
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerSync",
  group = vim.api.nvim_create_augroup("Packer", { clear = true }),
  pattern = "plugins.lua",
})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use({
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      require("dlvhdr.theme")
      require("dlvhdr.colors")
      require("dlvhdr.tabline")
    end,
  })

  use("lewis6991/impatient.nvim")

  use("nvim-lua/plenary.nvim")
  use({
    "L3MON4D3/LuaSnip",
    config = "require('dlvhdr.luasnip')",
  })
  use({ "hrsh7th/nvim-cmp" })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
  use({ "onsails/lspkind-nvim" })
  use({ "nathom/filetype.nvim" })

  use({ "neovim/nvim-lspconfig" })
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("dlvhdr.cmp")
      require("dlvhdr.lsp")
      require("dlvhdr.lspsaga")
    end,
  })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({ "folke/lua-dev.nvim" })

  -- use({
  --   "ray-x/lsp_signature.nvim",
  -- })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('dlvhdr.treesitter')",
  })

  use({
    "nvim-treesitter/playground",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  })

  use({
    "windwp/nvim-ts-autotag",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  })

  use("kosayoda/nvim-lightbulb", {
    config = "require('dlvhdr.lightbulb')",
  })

  -- IDE capabilites
  use({
    "nvim-lualine/lualine.nvim",
    config = "require('dlvhdr.lualine')",
  })
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
    tag = "0.1.0",
    config = "require('dlvhdr.telescope')",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "folke/trouble.nvim" },
    },
  })

  use({ "axkirillov/easypick.nvim", requires = "nvim-telescope/telescope.nvim" })

  -- use({
  --   "norcalli/nvim-colorizer.lua",
  --   config = "require('dlvhdr.colorizer')",
  -- })
  -- use({
  --   "rrethy/vim-hexokinase",
  --   run = "make hexokinase",
  --   config = function()
  --     vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
  --   end,
  -- })

  use("moll/vim-bbye")

  -- File Explorer
  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    },
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

  use({
    "mg979/vim-visual-multi",
    config = "require('dlvhdr.vim-visual-multi')",
  })

  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({
    "ldelossa/gh.nvim",
    requires = { "ldelossa/litee.nvim" },
    config = "require('dlvhdr.gh-nvim')",
  })

  -- use({
  --   "lukvbaal/stabilize.nvim",
  --   config = function()
  --     require("stabilize").setup()
  --   end,
  -- })

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
