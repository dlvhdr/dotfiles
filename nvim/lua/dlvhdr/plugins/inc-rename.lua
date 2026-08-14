return {
  "smjonas/inc-rename.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = "IncRename",
  enabled = false,
  config = function()
    require("inc_rename").setup({
      cmd_name = "IncRename",
      hl_group = "Substitute",
      input_buffer_type = "snacks",
      preview_empty_name = true,
      save_in_cmdline_history = false,
      show_message = true,
    })
  end,
}
