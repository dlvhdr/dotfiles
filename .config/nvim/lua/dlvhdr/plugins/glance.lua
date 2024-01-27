return {
  "dnlhc/glance.nvim",
  dependencies = { "folke/trouble.nvim" },
  cmd = "Glance",
  keys = {
    { "gd", "<CMD>Glance definitions<CR>", desc = "Show Definitions" },
    { "gr", "<CMD>Glance references<CR>", desc = "Show References" },
    { "gY", "<CMD>Glance type_definitions<CR>", desc = "Show Type Definitions" },
    { "gi", "<CMD>Glance implementations<CR>", desc = "Show Implementation" },
  },
  config = function()
    local utils = require("dlvhdr.utils")
    ---@diagnostic disable: missing-fields
    require("glance").setup({
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─",
      },
      list = {
        width = 0.4,
      },
      theme = {
        enable = false,
      },
      folds = {
        folded = false,
      },
      mappings = {
        list = {
          ["<c-t>"] = function()
            local glance = require("glance")
            glance.actions.quickfix()
            vim.cmd("cclose")
            vim.cmd("Trouble quickfix")
          end,
        },
      },
      hooks = {
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1])
            vim.cmd("normal zt")
            return
          end

          local filtered_results
          if method ~= "definitions" then
            filtered_results = results
          else
            filtered_results = utils.filter(results, utils.filterReactDTS)
          end

          if #filtered_results == 1 then
            jump(filtered_results[1])
            vim.cmd("normal zt")
          else
            open(filtered_results)
          end
        end,
        after_close = function()
          vim.cmd("normal zt")
        end,
      },
    })

    local colors = require("tokyonight.colors").setup()
    vim.api.nvim_set_hl(0, "GlanceWinBarTitle", { fg = colors.blue, bg = colors.bg_float, bold = true })
    vim.api.nvim_set_hl(0, "GlanceListNormal", { bg = colors.bg_float })
    vim.api.nvim_set_hl(0, "GlancePreviewNormal", { bg = colors.bg_dark })
    vim.api.nvim_set_hl(0, "GlanceBorderTop", { fg = colors.border_highlight, bg = colors.bg_dark })
    vim.api.nvim_set_hl(0, "GlanceWinBarFilename", { fg = colors.fg_dark, bg = colors.bg_dark, bold = true })
    vim.api.nvim_set_hl(0, "GlanceWinBarFilepath", { fg = colors.fg_dark, bg = colors.bg_dark })
    vim.api.nvim_set_hl(0, "GlancePreviewBorderBottom", { fg = colors.border_highlight, bg = colors.bg_dark })
    vim.api.nvim_set_hl(0, "GlanceListMatch", { bg = colors.none, fg = colors.yellow })
    vim.api.nvim_set_hl(0, "GlancePreviewMatch", { fg = colors.bg_dark, bg = colors.yellow })
    vim.api.nvim_set_hl(0, "GlanceListBorderBottom", { fg = colors.border_highlight, bg = colors.bg_dark })
  end,
}
