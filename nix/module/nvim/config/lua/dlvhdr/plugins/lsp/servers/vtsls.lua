local M = {}

local lspconfig = require("lspconfig")

M.setup = function(opts)
  require("lspconfig").vtsls.setup({
    on_attach = function(client, bufnr)
      opts.on_attach(client, bufnr)
      client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
        ---@type string, string, lsp.Range
        local action, uri, range = unpack(command.arguments)

        local function move(newf)
          client.request("workspace/executeCommand", {
            command = command.command,
            arguments = { action, uri, range, newf },
          })
        end

        local fname = vim.uri_to_fname(uri)
        client.request("workspace/executeCommand", {
          command = "typescript.tsserverRequest",
          arguments = {
            "getMoveToRefactoringFileSuggestions",
            {
              file = fname,
              startLine = range.start.line + 1,
              startOffset = range.start.character + 1,
              endLine = range["end"].line + 1,
              endOffset = range["end"].character + 1,
            },
          },
        }, function(_, result)
          ---@type string[]
          local files = result.body.files
          table.insert(files, 1, "Enter new path...")
          vim.ui.select(files, {
            prompt = "Select move destination:",
            format_item = function(f)
              return vim.fn.fnamemodify(f, ":~:.")
            end,
          }, function(f)
            if f and f:find("^Enter new path") then
              vim.ui.input({
                prompt = "Enter move destination:",
                default = vim.fn.fnamemodify(fname, ":h") .. "/",
                completion = "file",
              }, function(newf)
                return newf and move(newf)
              end)
            elseif f then
              move(f)
            end
          end)
        end)
      end
    end,
    capabilities = opts.capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
    init_options = {
      plugins = {
        {
          name = "@styled/typescript-styled-plugin",
          location = vim.env.XDG_DATA_HOME .. "/npm/lib/node_modules/@styled/typescript-styled-plugin",
        },
      },
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = false,
          },
        },
      },
      typescript = {
        preferences = {
          autoImportFileExcludePatterns = {
            "**/lodash/**",
            "**/process/**",
            "**/events/**",
            "date-fns",
            "date-fns/esm",
          },
        },
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        -- inlayHints = {
        --   enumMemberValues = { enabled = true },
        --   functionLikeReturnTypes = { enabled = true },
        --   parameterNames = { enabled = "literals" },
        --   parameterTypes = { enabled = true },
        --   propertyDeclarationTypes = { enabled = true },
        --   variableTypes = { enabled = false },
        -- },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        -- inlayHints = {
        --   enumMemberValues = { enabled = true },
        --   functionLikeReturnTypes = { enabled = true },
        --   parameterNames = { enabled = "literals" },
        --   parameterTypes = { enabled = true },
        --   propertyDeclarationTypes = { enabled = true },
        --   variableTypes = { enabled = false },
        -- },
      },
    },
  })

  vim.keymap.set(
    "n",
    "<leader>lu",
    require("dlvhdr.plugins.lsp.handlers").action["source.removeUnused.ts"],
    { desc = "Remove unused" }
  )
  vim.keymap.set(
    "n",
    "<leader>lm",
    require("dlvhdr.plugins.lsp.handlers").action["source.addMissingImports.ts"],
    { desc = "Add missing imports" }
  )
end

return M
