return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "mdx" },
    after = { "nvim-treesitter" },
    requires = { "echasnovski/mini.nvim", opt = true },
    config = function()
      vim.cmd([[highlight Headline1Fg cterm=bold gui=bold guifg=#ffffff]])
      vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#ffffff", default = true })
      vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#ffffff", default = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = "#080808" })
      vim.api.nvim_set_hl(0, "CodeInline", { bg = "#1A1B26", fg = "#c2c6f0" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "CodeInline" })
      vim.api.nvim_set_hl(0, "@markup.raw", { link = "CodeInline" })
      vim.api.nvim_set_hl(0, "@markup.list", { link = "@markup.strong" })
      require("render-markdown").setup({
        file_types = { "markdown", "mdx" },
        anti_conceal = {},
        heading = {
          border = true,
          above = "",
          width = "block",
          below = "─",
          backgrounds = {
            "@markup.strong",
          },
          foregrounds = {
            "@markup.strong",
          },
        },
        bullet = {
          enabled = true,
          icons = { "•", "∘", "▪", "▫", "" },
          highlight = "@markup.strong",
        },
        dash = {
          highlight = "@markup.strong",
        },
        pipe_table = {
          head = "@markup.strong",
          row = "@markup.strong",
          filler = "@markup.strong",
        },
        code = {
          width = "block",
          min_width = 80,
          highlight = "CodeBlock",
          highlight_inline = "CodeInline",
        },
      })
    end,
  },
}
