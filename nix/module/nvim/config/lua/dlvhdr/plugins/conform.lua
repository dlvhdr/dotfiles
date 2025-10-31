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
  astro = { "prettierd" },
  mdx = { "prettierd" },
  json = { "prettierd" },
  yaml = { "prettierd" },
  go = { "gofumpt", "goimports-reviser" },
  python = { "black" },
  nix = { "nixfmt" },
}

return {
  "stevearc/conform.nvim",
  ft = vim.tbl_keys(formatters_by_ft),
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = formatters_by_ft,
      formatters = {
        -- astro = {
        --   command = "prettierd",
        --   prepend_args = {
        --     "--plugin=prettier-plugin-astro",
        --     "--plugin=prettier-plugin-tailwindcss",
        --   },
        --   args = { "$FILENAME" },
        --   range_args = function(self, ctx)
        --     local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)
        --     return { "$FILENAME", "--range-start=" .. start_offset, "--range-end=" .. end_offset }
        --   end,
        --   cwd = require("conform.util").root_file({ "astro.config.mjs" }),
        -- },
        gofumpt = {
          env = {
            GOFUMPT_SPLIT_LONG_LINES = "on",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>lF", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify("Auto formatting is " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
    end, { desc = "Auto Formatting" })

    local wk = require("which-key")
    wk.add({
      { "<leader>lF", icon = "󰨚 " },
    })

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
          lsp_fallback = false,
        })
      end,
    })
  end,
}
