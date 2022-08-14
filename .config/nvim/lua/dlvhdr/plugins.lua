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
    config = function()
      require("dlvhdr.luasnip")
    end,
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

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("dlvhdr.treesitter")
    end,
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

  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-lua/lsp-status.nvim",
    },
    config = function()
      require("dlvhdr.lualine")
    end,
  })

  use({
    "glepnir/dashboard-nvim",
    config = function()
      require("dlvhdr.dashboard")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("dlvhdr.gitsigns")
    end,
  })
  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("dlvhdr.dap")
    end,
  })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("dlvhdr.autopairs")
    end,
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("dlvhdr.fidget")
    end,
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
    config = function()
      require("dlvhdr.indent-blankline")
    end,
  })

  use("tpope/vim-eunuch")

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    config = function()
      require("dlvhdr.telescope")
    end,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "folke/trouble.nvim" },
      { "axkirillov/easypick.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
  })

  use({
    "rrethy/vim-hexokinase",
    run = "make hexokinase",
    config = function()
      vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
    end,
  })

  use({
    "famiu/bufdelete.nvim",
    config = function()
      require("dlvhdr.bufdelete")
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("dlvhdr.nvim-tree")
    end,
  })

  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("dlvhdr.persistence")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("dlvhdr.diffview")
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("dlvhdr.comment")
    end,
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
  })

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
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
    config = function()
      require("dlvhdr.vim-visual-multi")
    end,
  })

  use({
    "ldelossa/gh.nvim",
    config = function()
      require("dlvhdr.gh-nvim")
    end,
    requires = { "ldelossa/litee.nvim" },
  })

  use({
    "williamboman/mason.nvim",
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  })
  use("MunifTanjim/prettier.nvim")

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("dlvhdr.auto-save")
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
