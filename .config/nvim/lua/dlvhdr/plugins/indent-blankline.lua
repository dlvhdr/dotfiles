local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
}

M.config = function()
  local status_ok, indent_blankline = pcall(require, "ibl")
  if not status_ok then
    return
  end

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
        "sagasignature",
        "sagahover",
        "lspsagafinder",
        "LspSagaCodeAction",
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
    indent = { char = "▏" },
    scope = {
      show_start = false,
      show_end = false,
    },
  })
end

return M
