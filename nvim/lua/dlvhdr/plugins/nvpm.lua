return {
  "mistweaverco/nvpm.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    ---@type NvpmConfigLsp
    lsp = {
      -- Defaults to `true`, set to `false` to disable
      -- Loads "custom" user configurations for LSP servers from
      -- `vim.fn.stdpath('config') .. "/lsp/<server>.lua`
      -- If you're using `nvim-lspconfig`,
      -- You probably want to disable this.
      loader = false,
    },
    ---@type NvpmConfigTreesitter
    treesitter = {
      -- Defaults to `true`, set to `false` to disable
      -- Loads "custom" user configurations for LSP servers from
      -- `vim.fn.stdpath('data') .. "/site/parser/<ft>.{so,dylib,dll}`
      -- `vim.fn.stdpath('data') .. "/site/queries/<ft>/*.scm`
      -- If you're using another plugin to manage treesitter parsers and queries,
      -- You probably want to disable this.
      loader = true,
    },
  },
}
