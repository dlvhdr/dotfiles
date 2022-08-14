local M = {}

local null_ls = require("null-ls")
local utils = require("dlvhdr.utils")
local lspconfigUtils = require("lspconfig.util")
local prettier = require("prettier")

local has_eslint_config = function()
  return lspconfigUtils.root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js")(vim.fn.getcwd()) ~= nil
end

local function prettier_eslint_check()
  local has_eslint = false
  local cwd = vim.fn.getcwd()

  if has_eslint_config() then
    has_eslint = true
  else
    local rootJsonPath = lspconfigUtils.root_pattern("package.json")(cwd)
    if rootJsonPath then
      local rootJson = utils.read_json(lspconfigUtils.path.join(rootJsonPath, "package.json"))
      if rootJson.eslintConfig ~= nil then
        has_eslint = true
      end
    end

    local ancestorJsonPath = lspconfigUtils.find_package_json_ancestor()
    if ancestorJsonPath then
      local localJson = utils.read_json(ancestorJsonPath)
      if localJson.eslintConfig ~= nil then
        has_eslint = true
      end
    end
  end

  if has_eslint then
    local has_prettier_plugin = lspconfigUtils.root_pattern("node_modules/eslint-plugin-prettier/package.json")
    if has_prettier_plugin then
      return "eslint"
    end
  end

  return "prettier"
end

local jsFormatter = function()
  local formatter = prettier_eslint_check()

  if formatter == "eslint" then
    return null_ls.builtins.formatting.eslint_d.with({})
  else
    return nil
    -- return null_ls.builtins.formatting.prettierd.with({
    --   filetypes = {
    --     "javascript",
    --     "javascriptreact",
    --     "typescript",
    --     "typescriptreact",
    --     "vue",
    --     "css",
    --     "scss",
    --     "less",
    --     "html",
    --     "json",
    --     "yaml",
    --     "yml",
    --     -- "markdown",
    --     "graphql",
    --   },
    -- })
  end
end

M.setup = function(opts)
  null_ls.setup({
    root_dir = lspconfigUtils.root_pattern(".git"),
    sources = {
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "sh" } }),
      null_ls.builtins.formatting.stylua.with({
        condition = function()
          return lspconfigUtils.root_pattern("stylua.toml")
        end,
      }),
      -- jsFormatter,
      -- null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.diagnostics.eslint_d.with({
        condition = function()
          local has = has_eslint_config()
          return has
        end,
      }),
    },
    on_attach = opts.on_attach,
  })

  prettier.setup({
    bin = "prettierd",
    arrow_parens = "always",
    bracket_spacing = false,
    bracket_same_line = true,
    embedded_language_formatting = "auto",
    end_of_line = "lf",
    html_whitespace_sensitivity = "css",
    jsx_single_quote = false,
    print_width = 80,
    prose_wrap = "preserve",
    quote_props = "as-needed",
    semi = true,
    single_attribute_per_line = false,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
    use_tabs = false,
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  })
end

return M
