---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup({})
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {
        icons = {
          collapsed = "",
          current_frame = "",
          expanded = "",
        },
        layouts = {
          {
            elements = {
              "repl",
              "stacks",
              "breakpoints",
              "watches",
            },
            size = 30,
            position = "left",
          },
          {
            elements = { "scopes" },
            size = 10,
            position = "bottom",
          },
        },
      },
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)

        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end

        -- vim.print("Configuring dap-vscode-js")
        -- vim.print(
        --   require("mason-registry").get_package("js-debug-adapter"):get_install_path()
        --     .. "/js-debug/src/dapDebugServer.js",
        --   "${port}"
        -- )

        if not dap.adapters["pwa-node"] then
          require("dap").adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = "node",
              -- 💀 Make sure to update this path to point to your installation
              args = {
                require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                  .. "/js-debug/src/dapDebugServer.js",
                "${port}",
              },
            },
          }
        end
        for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
          if not dap.configurations[language] then
            dap.configurations[language] = {
              {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
              },
              {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
            }
          end
        end
      end,
    },
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
    {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup({
          dap_configurations = {
            {
              type = "go",
              name = "Attach remote",
              mode = "remote",
              request = "attach",
            },
          },
          delve = {
            path = "dlv",
            initialize_timeout_sec = 20,
            port = "${port}",
            args = {},
            build_flags = "",
          },
        })
      end,
      -- stylua: ignore
      keys = {
        { "<leader>dt", function() require('dap-go').debug_test() end, desc = "Debug Test" },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dT", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  config = function()
    local icons = {
      Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    }
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(icons) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}
