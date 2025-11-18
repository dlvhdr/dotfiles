return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
    { "<leader>Ro", desc = "Open Kulala" },
  },
  -- ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    lsp = { formatter = true },
    ui = {
      ---@type table<string, string|vim.api.keyset.highlight>
      syntax_hl = {
        ["@punctuation.bracket.kulala_http"] = "Number",
        ["@character.special.kulala_http"] = "Special",
        ["@operator.kulala_http"] = "Special",
        ["@variable.kulala_http"] = "String",
        ["@redirect_path.kulala_http"] = "Number",
        ["@external_body_path.kulala_http"] = "String",
      },
    },
  },
}
