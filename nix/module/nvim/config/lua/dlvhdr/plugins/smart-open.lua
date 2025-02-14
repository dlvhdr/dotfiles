local get_opts = function()
  return {
    cwd_only = true,
    preview = { hide_on_startup = true },
    layout_config = {
      width = 0.65,
      height = 0.35,
    },
    mappings = {
      i = {
        ["<C-w>"] = function()
          vim.api.nvim_input("<c-s-w>")
        end,
      },
    },
    open_buffer_indicators = {
      previous = "󱞹",
      others = "",
    },
  }
end

return {
  "danielfalk/smart-open.nvim",
  enabled = false,
  cmd = { "SmartOpen" },
  dependencies = {
    "kkharji/sqlite.lua",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<C-p>",
      function()
        local opts = get_opts()
        require("telescope").extensions.smart_open.smart_open(opts)
      end,
      desc = "Project Files",
    },
  },
  config = function()
    require("telescope").load_extension("smart_open")
    local colors = require("tokyonight.colors").setup()
    vim.api.nvim_set_hl(0, "Directory", { fg = colors.comment })

    local opts = get_opts()
    vim.api.nvim_create_user_command("SmartOpen", function()
      require("telescope").extensions.smart_open.smart_open(opts)
    end, {})
  end,
}
