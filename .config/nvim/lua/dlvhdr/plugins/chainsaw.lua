return {
  "chrisgrieser/nvim-chainsaw",
  config = function()
    local beep_format = {
      "/* prettier-ignore */ // %s",
      'console.log("%s beep %s");',
    }
    local var_format = {
      "/* prettier-ignore */ // %s",
      'console.log("%s %s:", %s);',
    }
    local message_format = {
      "/* prettier-ignore */ // %s",
      'console.log("%s ");',
    }
    ---@diagnostic disable: missing-fields
    require("chainsaw").setup({
      marker = "[🪲 dolev]",
      logStatements = {
        beepLog = {
          javascript = beep_format,
          javascriptreact = beep_format,
          typescript = beep_format,
          typescriptreact = beep_format,
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
        require("chainsaw").beepLog()
      end,
      desc = "Beep Log",
    },
    {
      "<leader>dlr",
      function()
        require("chainsaw").removeLogs()
      end,
      desc = "Remove Logs",
    },
  },
}
