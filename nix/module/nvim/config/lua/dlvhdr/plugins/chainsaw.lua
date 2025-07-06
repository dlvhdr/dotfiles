return {
  {
    "Goose97/timber.nvim",
    enabled = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("timber").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
    keys = {
      {
        "<leader>dll",
        function()
          return require("timber.actions").insert_log({ position = "below", operator = true }) .. "_"
        end,
        desc = "Message Log",
      },
      {
        "<leader>dlv",
        function()
          require("timber.actions").insert_log({ template = "plain", position = "below" })
        end,
        desc = "Variable Log",
      },
    },
  },
  {
    "chrisgrieser/nvim-chainsaw",
    dependencies = "folke/which-key.nvim",
    config = function()
      local emoji_format = {
        "/* prettier-ignore */ // {{marker}}",
        "console.log(`${new Date().toISOString()}{{marker}} {{index}}`);",
      }
      local var_format = {
        "/* prettier-ignore */ // {{marker}}",
        "console.log(`${new Date().toISOString()}{{marker}} {{var}}:`, {{var}});",
      }
      local message_format = {
        "/* prettier-ignore */ // {{marker}}",
        "console.log(`${new Date().toISOString()}{{marker}} `);",
      }
      ---@diagnostic disable: missing-fields
      require("chainsaw").setup({
        marker = "[🪲 dlv]",
        logStatements = {
          emojiLog = {
            javascript = emoji_format,
            javascriptreact = emoji_format,
            typescript = emoji_format,
            typescriptreact = emoji_format,
          },
          variableLog = {
            javascript = var_format,
            javascriptreact = var_format,
            typescript = var_format,
            typescriptreact = var_format,
          },
          messageLog = {
            javascript = message_format,
            javascriptreact = message_format,
            typescript = message_format,
            typescriptreact = message_format,
          },
        },
      })

      local wk = require("which-key")
      wk.add({
        { "<leader>dl", group = " Log", nowait = false, remap = false },
      })
    end,
    keys = {
      {
        "<leader>dlm",
        function()
          require("chainsaw").messageLog()
        end,
        desc = "Message Log",
      },
      {
        "<leader>dlv",
        function()
          require("chainsaw").variableLog()
        end,
        desc = "Variable Log",
      },
      {
        "<leader>dlb",
        function()
          require("chainsaw").emojiLog()
        end,
        desc = "Emoji Log",
      },
      {
        "<leader>dlr",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "Remove Logs",
      },
    },
  },
}
