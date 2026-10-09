vim.api.nvim_create_user_command("KulalaOpenOpenAPIExplorer", function(args)
  require("kulala").set_selected_env(args.fargs[1])
  require("kulala").open_openapi_explorer()
end, {
  desc = "Open Kulala",
  bang = false,
  nargs = 1,
})

return {
  "mistweaverco/kulala.nvim",
  event = { "SessionLoadPost", "VimLeavePre" },
  cmd = { "KulalaOpen" },
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
    { "<leader>Ro", desc = "Open Kulala" },
  },
  ft = { "http", "rest", "javascript", "lua", "kulala-openapi" },
  config = function()
    require("kulala").setup({
      kulala_core = {
        data_dir = vim.fn.stdpath("data") .. "/kulala-core",
      },
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps = {
        ["Next response"] = {
          "}",
          function()
            require("kulala.ui").show_next()
          end,
        },
        ["Previous response"] = {
          "}",
          function()
            require("kulala.ui").show_previous()
          end,
        },
        ["Next tab"] = {
          "]",
          function()
            require("kulala.ui").show_next_tab()
          end,
        },
        ["Previous tab"] = {
          "[",
          function()
            require("kulala.ui").show_previous_tab()
          end,
        },
      },
      ui = {
        max_response_size = 1000000,
      },
    })
  end,
}
