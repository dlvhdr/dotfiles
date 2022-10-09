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

-- Automatically regenerate compiled loader file on save
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = vim.api.nvim_create_augroup("Packer", { clear = true }),
  pattern = "plugins.lua",
})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("lewis6991/impatient.nvim")

  use({ "nvim-lua/plenary.nvim", module = "plenary" })

  use({
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      require("dlvhdr.theme")
      require("dlvhdr.colors")
      require("dlvhdr.tabline")
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("dlvhdr.luasnip")
    end,
  })

  use({ "neovim/nvim-lspconfig" })
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind-nvim",
      "nathom/filetype.nvim",
    },
  })
  use({ "b0o/schemastore.nvim" })

  use({ "folke/lua-dev.nvim" })
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

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("dlvhdr.treesitter")
    end,
  })

  use({
    "nvim-treesitter/playground",
    after = "nvim-treesitter",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  })

  use({
    "aarondiel/spread.nvim",
    after = "nvim-treesitter",
    config = function()
      require("dlvhdr.spread")
    end,
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  })

  use("kosayoda/nvim-lightbulb", {
    config = "require('dlvhdr.lightbulb')",
  })

  use({
    "vigoux/notifier.nvim",
    config = function()
      require("notifier").setup({
        -- You configuration here
      })
    end,
  })

  use({
    "rcarriga/nvim-notify",
    config = function()
      require("dlvhdr.notify")
    end,
  })

  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("dlvhdr.noice")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-lua/lsp-status.nvim",
    },
    event = "VimEnter",
    after = "nvim-treesitter",
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
    event = "BufRead",
    config = function()
      require("dlvhdr.gitsigns")
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("dlvhdr.autopairs")
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
    event = "BufReadPre",
    config = function()
      require("dlvhdr.indent-blankline")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    config = function()
      require("dlvhdr.telescope")
    end,
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  })

  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("dlvhdr.colorizer")
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
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  })

  use({
    "numToStr/Comment.nvim",
    event = "BufRead",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("dlvhdr.comment")
    end,
  })

  use({
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use("christoomey/vim-tmux-navigator")
  use({
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  })

  use({
    "jxnblk/vim-mdx-js",
    ft = { "mdx", "markdown.mdx" },
  })

  use({
    "mg979/vim-visual-multi",
    config = function()
      require("dlvhdr.vim-visual-multi")
    end,
  })

  use({
    "williamboman/mason.nvim",
    module = { "mason" },
    cmd = { "Mason", "MasonInstall", "Mason*" },
    requires = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  })

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("dlvhdr.auto-save")
    end,
  })

  use({
    "RRethy/vim-illuminate",
    config = function()
      require("dlvhdr.illuminate")
    end,
  })

  use({
    "utilyre/barbecue.nvim",
    config = function()
      require("dlvhdr.barbecue")
    end,
    requires = {
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional
    },
  })

  -- use({
  --   "ldelossa/gh.nvim",
  --   config = function()
  --     require("dlvhdr.gh-nvim")
  --   end,
  --   requires = { "ldelossa/litee.nvim" },
  -- })
  --
  -- use("MunifTanjim/prettier.nvim")
  --
  -- use("tpope/vim-eunuch")
  --
  -- use({
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     require("dlvhdr.dap")
  --   end,
  -- })
  --
  -- use({"axkirillov/easypick.nvim"})

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
