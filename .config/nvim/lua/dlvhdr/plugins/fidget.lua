return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function(opts)
    vim.cmd("hi! FidgetTitle ctermbg=NONE guibg=NONE")
    vim.cmd("hi! FidgetTask ctermbg=NONE guibg=NONE")
    require("fidget").setup({
      progress = {
        ignore = { "lua_ls" },
        display = {
          done_ttl = 1,
        },
      },
      notification = {
        window = {
          winblend = 0,
        },
      },
    })
  end,
}
