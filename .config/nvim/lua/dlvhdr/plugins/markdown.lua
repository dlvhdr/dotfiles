return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx" },
    after = { "nvim-treesitter" },
    requires = { "echasnovski/mini.nvim", opt = true },
    config = function()
      vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#ffffff", default = true })
      vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#ffffff", default = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#16161e" })
      vim.api.nvim_set_hl(0, "CodeInline", { bg = "#1A1B26", fg = "#9199ed" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "CodeInline" })
      vim.api.nvim_set_hl(0, "@markup.raw", { link = "CodeInline" })
      vim.api.nvim_set_hl(0, "@markup.list", { link = "@markup.strong" })
      require("render-markdown").setup({
        file_types = { "markdown", "mdx" },
        render_modes = true,
        sign = { enabled = false },
        anti_conceal = {},
        heading = {
          border = true,
          above = "",
          width = "block",
          below = "─",
          backgrounds = {
            "@markup.strong",
          },
        },
        bullet = {
          enabled = true,
          icons = { "•", "∘", "▪", "▫", "" },
          highlight = "@markup.strong",
        },
        dash = {
          highlight = "Comment",
        },
        pipe_table = {
          head = "@markup.strong",
          row = "@markup.strong",
          filler = "@markup.strong",
        },
        code = {
          border = "thin",
          left_pad = 2,
          width = "block",
          min_width = 80,
          highlight = "CodeBlock",
          position = "right",
          language_pad = 1,
          highlight_inline = "CodeInline",
        },
      })
    end,
  },
}
