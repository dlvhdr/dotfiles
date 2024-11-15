return {
  "towolf/vim-helm",
  ft = { "helm", "tpl" },
  dependencies = { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile", "BufEnter" } },
}
