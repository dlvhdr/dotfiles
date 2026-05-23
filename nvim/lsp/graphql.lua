return {
  -- cli: https://github.com/graphql/graphiql/blob/main/packages/graphql-language-service-server/README.md
  -- lsp: https://www.npmjs.com/package/graphql-language-service-cli
  -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/graphql.lua
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql" },
  settings = {
    graphql = {},
  },
}
