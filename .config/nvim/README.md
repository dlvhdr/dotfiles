# dotfiles/.config/nvim

<a href="https://dotfyle.com/dlvhdr/dotfiles-config-nvim"><img src="https://dotfyle.com/dlvhdr/dotfiles-config-nvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/dlvhdr/dotfiles-config-nvim"><img src="https://dotfyle.com/dlvhdr/dotfiles-config-nvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/dlvhdr/dotfiles-config-nvim"><img src="https://dotfyle.com/dlvhdr/dotfiles-config-nvim/badges/plugin-manager?style=flat" /></a>

## Install Instructions

 > Install requires Neovim 0.9+. Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:dlvhdr/dotfiles ~/.config/dlvhdr/dotfiles
NVIM_APPNAME=dlvhdr/dotfiles/.config/nvim nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=dlvhdr/dotfiles/.config/nvim nvim
```

## Plugins

### ai

+ [jackMort/ChatGPT.nvim](https://dotfyle.com/plugins/jackMort/ChatGPT.nvim)
### bars-and-lines

+ [utilyre/barbecue.nvim](https://dotfyle.com/plugins/utilyre/barbecue.nvim)
+ [SmiteshP/nvim-navic](https://dotfyle.com/plugins/SmiteshP/nvim-navic)
+ [luukvbaal/statuscol.nvim](https://dotfyle.com/plugins/luukvbaal/statuscol.nvim)
### color

+ [NvChad/nvim-colorizer.lua](https://dotfyle.com/plugins/NvChad/nvim-colorizer.lua)
### colorscheme

+ [folke/tokyonight.nvim](https://dotfyle.com/plugins/folke/tokyonight.nvim)
### comment

+ [JoosepAlviste/nvim-ts-context-commentstring](https://dotfyle.com/plugins/JoosepAlviste/nvim-ts-context-commentstring)
### completion

+ [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)
+ [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
### cursorline

+ [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)
### debugging

+ [chrisgrieser/nvim-chainsaw](https://dotfyle.com/plugins/chrisgrieser/nvim-chainsaw)
+ [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
+ [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)
### dependency-management

+ [piersolenski/telescope-import.nvim](https://dotfyle.com/plugins/piersolenski/telescope-import.nvim)
+ [vuki656/package-info.nvim](https://dotfyle.com/plugins/vuki656/package-info.nvim)
### diagnostics

+ [chrisgrieser/nvim-rulebook](https://dotfyle.com/plugins/chrisgrieser/nvim-rulebook)
+ [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)
### editing-support

+ [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)
+ [windwp/nvim-autopairs](https://dotfyle.com/plugins/windwp/nvim-autopairs)
+ [windwp/nvim-ts-autotag](https://dotfyle.com/plugins/windwp/nvim-ts-autotag)
+ [Wansmer/treesj](https://dotfyle.com/plugins/Wansmer/treesj)
+ [NStefan002/visual-surround.nvim](https://dotfyle.com/plugins/NStefan002/visual-surround.nvim)
+ [gbprod/substitute.nvim](https://dotfyle.com/plugins/gbprod/substitute.nvim)
+ [axelvc/template-string.nvim](https://dotfyle.com/plugins/axelvc/template-string.nvim)
### file-explorer

+ [kyazdani42/nvim-tree.lua](https://dotfyle.com/plugins/kyazdani42/nvim-tree.lua)
### formatting

+ [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)
+ [gpanders/editorconfig.nvim](https://dotfyle.com/plugins/gpanders/editorconfig.nvim)
### fuzzy-finder

+ [fdschmidt93/telescope-egrepify.nvim](https://dotfyle.com/plugins/fdschmidt93/telescope-egrepify.nvim)
+ [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)
### git

+ [linrongbin16/gitlinker.nvim](https://dotfyle.com/plugins/linrongbin16/gitlinker.nvim)
+ [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
+ [aaronhallaert/advanced-git-search.nvim](https://dotfyle.com/plugins/aaronhallaert/advanced-git-search.nvim)
### github

+ [pwntester/octo.nvim](https://dotfyle.com/plugins/pwntester/octo.nvim)
+ [dlvhdr/gh-addressed.nvim](https://dotfyle.com/plugins/dlvhdr/gh-addressed.nvim)
+ [dlvhdr/gh-blame.nvim](https://dotfyle.com/plugins/dlvhdr/gh-blame.nvim)
### icon

+ [kyazdani42/nvim-web-devicons](https://dotfyle.com/plugins/kyazdani42/nvim-web-devicons)
### indent

+ [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
### keybinding

+ [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)
### lsp

+ [j-hui/fidget.nvim](https://dotfyle.com/plugins/j-hui/fidget.nvim)
+ [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)
+ [nvimtools/none-ls.nvim](https://dotfyle.com/plugins/nvimtools/none-ls.nvim)
+ [smjonas/inc-rename.nvim](https://dotfyle.com/plugins/smjonas/inc-rename.nvim)
### lsp-installer

+ [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)
### marks

+ [ThePrimeagen/harpoon](https://dotfyle.com/plugins/ThePrimeagen/harpoon)
### nvim-dev

+ [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
+ [kkharji/sqlite.lua](https://dotfyle.com/plugins/kkharji/sqlite.lua)
+ [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
+ [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
### plugin-manager

+ [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)
### snippet

+ [L3MON4D3/LuaSnip](https://dotfyle.com/plugins/L3MON4D3/LuaSnip)
+ [rafamadriz/friendly-snippets](https://dotfyle.com/plugins/rafamadriz/friendly-snippets)
### split-and-window

+ [famiu/bufdelete.nvim](https://dotfyle.com/plugins/famiu/bufdelete.nvim)
### startup

+ [goolord/alpha-nvim](https://dotfyle.com/plugins/goolord/alpha-nvim)
### statusline

+ [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)
### syntax

+ [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
+ [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
+ [RRethy/nvim-treesitter-textsubjects](https://dotfyle.com/plugins/RRethy/nvim-treesitter-textsubjects)
### tabline

+ [nanozuki/tabby.nvim](https://dotfyle.com/plugins/nanozuki/tabby.nvim)
### test

+ [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)
### treesitter-based

+ [drybalka/tree-climber.nvim](https://dotfyle.com/plugins/drybalka/tree-climber.nvim)
### utility

+ [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)
+ [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
+ [jghauser/mkdir.nvim](https://dotfyle.com/plugins/jghauser/mkdir.nvim)
+ [echasnovski/mini.nvim](https://dotfyle.com/plugins/echasnovski/mini.nvim)
+ [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
+ [chrisgrieser/nvim-genghis](https://dotfyle.com/plugins/chrisgrieser/nvim-genghis)
### yaml

+ [someone-stole-my-name/yaml-companion.nvim](https://dotfyle.com/plugins/someone-stole-my-name/yaml-companion.nvim)
## Language Servers

+ gopls
+ html
+ lua_ls
+ marksman
+ tsserver
+ yamlls


 This readme was generated by [Dotfyle](https://dotfyle.com)
