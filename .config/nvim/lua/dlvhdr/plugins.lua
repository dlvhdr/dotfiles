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

  use({ "nvim-lua/plenary.nvim" })

  use({
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      require("dlvhdr.theme").setup()
      require("dlvhdr.colors")
      require("dlvhdr.tabline")
    end,
  })
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        override = {
          default_icon = {
            icon = "",
            color = "#c0caf5",
            cterm_color = "65",
            name = "Default",
          },
        },
      })
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
      -- "nathom/filetype.nvim",
    },
  })
  use({ "b0o/schemastore.nvim" })

  use({ "folke/neodev.nvim" })
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
    "Wansmer/treesj",
    requires = { "nvim-treesitter" },
    config = function()
      require("dlvhdr.treesj")
    end,
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  })

  -- use("kosayoda/nvim-lightbulb", {
  --   config = "require('dlvhdr.lightbulb')",
  -- })

  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("dlvhdr.noice")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
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

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("dlvhdr.indent-blankline")
    end,
  })

  use({ "natecraddock/telescope-zf-native.nvim" })

  use({
    "princejoogie/dir-telescope.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    branch = "dev",
    config = function()
      require("dir-telescope").setup({
        debug = true,
        respect_gitignore = true,
      })
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
    "NvChad/nvim-colorizer.lua",
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
      require("dlvhdr.mason")
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
      "SmiteshP/nvim-navic",
      "neovim/nvim-lspconfig",
      "kyazdani42/nvim-web-devicons", -- optional
    },
  })

  use({
    "pwntester/octo.nvim",
    config = function()
      require("dlvhdr.octo")
    end,
  })

  use({
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup({})
    end,
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("dlvhdr.ufo")
    end,
  })

  use({
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("dlvhdr.mason-tool-installer")
    end,
  })

  use({
    "nanozuki/tabby.nvim",
    config = function()
      require("dlvhdr.tabby")
    end,
    after = "tokyonight.nvim",
  })

  use({
    "/Users/dolevh/code/personal/github.com/PatschD/zippy.nvim",
    config = function()
      require("zippy").setup({
        ["typescriptreact"] = {
          format_fn = function(t)
            local filename = t.filename
            local line_nr = t.line_nr
            local breadcrumbs = t.breadcrumbs
            local current_text = t.current_text

            local t = '"%c[🐛 DEBUG]%c[📂 %s #%s]%c %s", "color: #9ece6a", "color: #a9b1d6", '
              .. '"'
              .. filename
              .. '", '
              .. '"'
              .. line_nr
              .. '", "color: white", '
              .. '"'
              .. current_text
              .. '", '
              .. current_text
            print(t)

            return t
          end,
        },
      })
    end,
  })
  -- use({
  --   "~/code/personal/github.com/ldelossa/gh.nvim",
  --   -- cmd = { "GHOpenPR" },
  --   config = function()
  --     require("dlvhdr.gh-nvim")
  --   end,
  --   requires = { { "~/code/personal/github.com/ldelossa/litee.nvim" } },
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
