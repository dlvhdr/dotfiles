return {
  "dnlhc/glance.nvim",
  lazy = true,
  keys = {
    { "gd", "<CMD>Glance definitions<CR>", desc = "Show Definitions" },
    { "gr", "<CMD>Glance references<CR>", desc = "Show References" },
    { "gY", "<CMD>Glance type_definitions<CR>", desc = "Show Type Definitions" },
    { "gM", "<CMD>Glance implementations<CR>", desc = "Show Implementation" },
  },
  config = function()
    local utils = require("dlvhdr.utils")
    require("glance").setup({
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─",
      },
      theme = {
        enable = false,
      },
      folds = {
        folded = false,
      },
      hooks = {
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1])
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
          else
            open(filtered_results)
          end
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
