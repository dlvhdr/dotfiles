local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}

-- M.tools = {
--   "prettierd",
--   "stylua",
--   "selene",
--   "luacheck",
--   "eslint_d",
--   "shellcheck",
--   "deno",
--   "shfmt",
-- }

-- function M.check()
--   local mr = require("mason-registry")
--   for _, tool in ipairs(M.tools) do
--     local p = mr.get_package(tool)
--     if not p:is_installed() then
--       p:install()
--     end
--   end
-- end

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
  -- M.check()
  require("mason-lspconfig").setup({
    ensure_installed = M.tools,
    automatic_installation = true,
  })
end

return M
