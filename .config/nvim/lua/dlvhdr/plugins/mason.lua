local M = {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonUpdate" },
  build = ":MasonUpdate",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}

function M.config()
  local tools = {
    "prettierd",
    "stylua",
    "luacheck",
    "eslint_d",
    "shellcheck",
    "shfmt",
  }
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })

  local mr = require("mason-registry")

  local function ensure_installed()
    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end

  if mr.refresh then
    mr.refresh(ensure_installed)
  else
    ensure_installed()
  end

  require("mason-lspconfig").setup({
    ensure_installed = {
      "tsserver",
      "gopls",
    },
    automatic_installation = true,
  })
end

return M
