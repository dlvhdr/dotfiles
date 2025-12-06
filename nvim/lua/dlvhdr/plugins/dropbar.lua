return {
  "Bekaboo/dropbar.nvim",
  event = "BufEnter",
  enabled = false,
  name = "dropbar",

  config = function()
    local bar = require("dropbar.bar")

    ---@class dropbar_source_t
    local smart_path = {
      get_symbols = function(buff, _, _)
        local stats = {}

        local abs_path = vim.api.nvim_buf_get_name(buff) -- Get absolute path of current buffer
        local cwd = vim.fn.getcwd()
        local rel_path = vim.fs.relpath(cwd, abs_path)

        if vim.bo[buff].modified then
          -- symbols[#symbols].name = symbols[#symbols].name .. ' [+]'
          -- symbols[#symbols].name_hl = 'DiffAdded'
          table.insert(
            stats,
            bar.dropbar_symbol_t:new({
              icon = "●",
              icon_hl = "WarningMsg",
              name = "modified",
              name_hl = "WarningMsg",
            })
          )
        end

        if rel_path then
          -- TODO: split path
          local fileName = vim.fn.fnamemodify(rel_path, ":t")
          local pathOnly = vim.fn.fnamemodify(rel_path, ":h")
          table.insert(
            stats,
            bar.dropbar_symbol_t:new({
              icon = "",
              icon_hl = "FileName",
              name = fileName,
              name_hl = "FileName",
            })
          )
          if pathOnly:match("^octo") then
            table.insert(
              stats,
              bar.dropbar_symbol_t:new({
                icon = " ",
                icon_hl = "FilePath",
                name = "",
                name_hl = "FilePath",
              })
            )
          elseif pathOnly ~= "." then
            table.insert(
              stats,
              bar.dropbar_symbol_t:new({
                icon = "",
                icon_hl = "Cursor",
                name = pathOnly,
                name_hl = "FilePath",
              })
            )
          end
        else
          local formatted_abs_path = vim.fn.fnamemodify(abs_path, ":~")
          table.insert(
            stats,
            bar.dropbar_symbol_t:new({
              icon = " ",
              icon_hl = "",
              name = formatted_abs_path,
              name_hl = "",
            })
          )
        end

        return stats
      end,
    }

    ---@class dropbar_source_t
    require("dropbar").setup({
      icons = {
        enabled = true,
        ui = {
          bar = {
            separator = "  ",
            extends = "…",
          },
        },
      },
      bar = {
        sources = function()
          return { smart_path }
        end,
      },
    })
  end,
}
