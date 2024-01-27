return {
  "someone-stole-my-name/yaml-companion.nvim",
  enabled = false,
  requires = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  ft = { "yaml", "helm" },
  config = function()
    require("telescope").load_extension("yaml_schema")

    local cfg = require("yaml-companion").setup({
      schemas = {
        {
          name = "Kubernetes 1.22.4",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
        },
      },
    })
    require("lspconfig")["yamlls"].setup(cfg)
  end,
}
