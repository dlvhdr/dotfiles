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
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          scroll_strategy = "cycle",
          color_devicons = true,
          layout_strategy = "horizontal",
          mappings = {
            i = {
              ["<C-w>"] = function()
                vim.cmd("normal vbd")
              end,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          layout_config = {
            scroll_speed = 10,
            width = 0.95,
            height = 0.85,
            prompt_position = "top",
            horizontal = {
              preview_width = function(_, cols, _)
                return math.floor(cols * 0.4)
              end,
            },
            vertical = {
              width = 0.9,
              height = 0.95,
              preview_height = 0.55,
            },
            flex = {
              horizontal = {
                preview_width = 0.7,
              },
            },
          },
        },
        extensions = {
          smart_open = {
            preview = { hide_on_startup = true },
            layout_config = {
              width = 0.65,
            },
            mappings = {
              i = {
                ["<C-w>"] = function()
                  vim.cmd("normal vbd")
                end,
                ["<esc>"] = require("telescope.actions").close,
              },
            },
          },
        },
      })
      require("telescope").load_extension("smart_open")
    end,
  },
  {
    "danielfalk/smart-open.nvim",
    -- enabled = false,
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
  },
}
