local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "folke/noice.nvim",
    "xiyaowong/transparent.nvim",
  },
  event = "VeryLazy",
}

M.config = function()
  local components = require("dlvhdr.plugins.lualine.components")

  local theme = require("dlvhdr.plugins.theme")
  local colors = theme.colors()
  if not colors then
    return
  end

  -- local tree_view_ok, tree_view = pcall(require, "nvim-tree.view")
  -- if not tree_view_ok then
  --   return
  -- end
  --
  -- local nvim_tree_shift = {
  --   function()
  --     local name = "󰙅 Nvim Tree"
  --     local winnr = tree_view.get_winnr()
  --     local empty_space = string.rep(" ", ((vim.api.nvim_win_get_width(winnr or 0) - #name) / 2))
  --     return empty_space .. name .. empty_space
  --   end,
  --   cond = tree_view.is_visible,
  --   color = { fg = colors.fg_dark, bg = "NONE", gui = "italic" },
  -- }

  require("lualine").setup({
    options = {
      theme = require("dlvhdr.plugins.transparent").theme(),
      globalstatus = true,
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { "dashboard", "Outline", "alpha" },
      icons_enabled = true,
      -- ignore_focus = { "NvimTree" },
    },
    tabline = {},
    extensions = {},
    sections = {
      lualine_a = {
        {
          "tabs",
          mode = 1,
          cond = function()
            return #vim.api.nvim_list_tabpages() > 1
          end,
          tabs_color = {
            active = { fg = colors.fg_dark, bg = "NONE" },
            inactive = { fg = colors.fg_dark, bg = "NONE" },
          },
          fmt = function(_, context)
            local curr = vim.fn.tabpagenr()
            if curr == context.tabnr then
              return ""
            end

            return ""
          end,
        },
        components.branch,
      },
      lualine_b = {
        components.diff,
      },
      lualine_c = {
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#f0a275", bg = "NONE" },
        },
        -- components.breadcrumbs,
      },
      lualine_x = {
        components.treesitter,
        components.lsp,
        -- components.filetype,
      },
      lualine_y = {},
      lualine_z = {
        components.location,
        components.scrollbar,
        -- nvim_tree_shift,
      },
    },
  })
end

return M
