local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
}

M.config = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

  local theme = require("dlvhdr.plugins.theme")
  local colors = theme.colors()
  if not colors then
    return
  end

  local util = require("tokyonight.util")
  local darker_bg = util.darken(colors.bg_popup, 2.5)
  vim.cmd("highlight IndentLineDarker guifg=" .. darker_bg)

  indent_blankline.setup({
    enabled = true,
    exclude = {
      filetypes = {
        "terminal",
        "nofile",
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "packer",
        "man",
        "TelescopePrompt",
        "NvimTree",
        "Trouble",
        "DiffviewFiles",
        "DiffviewFileHistory",
        "Outline",
        "lspinfo",
        "fugitive",
        "norg",
      },
    },
    indent = {
      char = "│",
      tab_char = "│",
      highlight = { "IndentLineDarker" },
    },
    scope = {
      show_start = false,
      show_end = false,
    },
  })

  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.ACTIVE, function(bufnr)
    return vim.api.nvim_buf_line_count(bufnr) < 5000
  end)
end

return M
