return {
  "utilyre/barbecue.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    "neovim/nvim-lspconfig",
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    local status_ok, barbecue = pcall(require, "barbecue")
    if not status_ok then
      return
    end

    local colors_status_ok, colors = pcall(require, "tokyonight.colors")
    if not colors_status_ok then
      return
    end

    colors = colors.setup({})

    vim.cmd("hi! NavicSeparator guibg=none guifg=" .. colors.dark3)
    vim.cmd("hi! BarbecueModified guibg=" .. colors.bg .. " guifg=" .. colors.yellow)

    barbecue.setup({
      attach_navic = false,
      show_modified = true,
      symbols = {
        prefix = " ",
        separator = "",
        modified = "●",
        default_context = "…",
      },
    })
  end,
}
