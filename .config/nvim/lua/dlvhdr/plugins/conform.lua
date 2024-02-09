local formatters_by_ft = {
  lua = { "stylua" },
  typescript = { "prettierd", "eslint_d" },
  typescriptreact = { "prettierd", "eslint_d" },
  javascript = { "prettierd", "eslint_d" },
  javascriptreact = { "prettierd", "eslint_d" },
  html = { "prettierd" },
  css = { "prettierd" },
  postcsss = { "prettierd" },
  markdown = { "prettierd" },
  json = { "prettierd" },
  yaml = { "prettierd" },
  go = { "gofmt", "goimports-reviser" },
  python = { "black" },
}

return {
  "stevearc/conform.nvim",
  ft = vim.tbl_keys(formatters_by_ft),
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = formatters_by_ft,
    })

    vim.keymap.set("n", "<leader>cF", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify("Auto formatting is " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
    end, { desc = "[Toggle] Auto Formatting" })

    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = "*",
      callback = function(e)
        local filetype = vim.bo[e.buf].filetype

        if not formatters_by_ft[filetype] or vim.g.disable_autoformat then
          return
        end

        conform.format({
          bufnr = e.buf,
          timeout_ms = 3000,
          lsp_fallback = true,
        })
      end,
    })
  end,
}
