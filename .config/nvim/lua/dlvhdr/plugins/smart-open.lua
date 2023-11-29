return {
  "danielfalk/smart-open.nvim",
  -- dir = "/Users/dlvhdr/code/personal/smart-open.nvim",
  -- dev = true,
  dependencies = {
    "kkharji/sqlite.lua",
  },
  branch = "0.2.x",
  config = function()
    require("telescope").load_extension("smart_open")
    local colors = require("tokyonight.colors").setup()
    vim.api.nvim_set_hl(0, "Directory", { fg = colors.comment })

    vim.api.nvim_create_user_command("SmartOpen", function()
      require("telescope").extensions.smart_open.smart_open({
        cwd_only = true,
        preview = { hide_on_startup = true },
        layout_config = {
          width = 0.65,
          height = 0.35,
        },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
        open_buffer_indicators = {
          previous = "󱪓",
          others = "󰘓",
        },
      })
    end, {})
  end,
}
