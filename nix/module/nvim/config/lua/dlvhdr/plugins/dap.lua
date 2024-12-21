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
      "jay-babu/mason-nvim-dap.nvim",
      enabled = false,
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "js-debug-adapter",
          "debugpy",
          "dlv",
        },
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
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

        if not dap.adapters["pwa-node"] then
          require("dap").adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = "node",
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
                request = "launch",
                name = "Debug Current Test File",
                autoAttachChildProcesses = true,
                skipFiles = { "<node_internals>/**", "**/node_modules/**" },
                cwd = "${workspaceFolder}",
                program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
                args = { "run", "${file}" },
                smartStep = true,
                console = "integratedTerminal",
              },
              {
                type = "pwa-node",
                request = "attach",
                name = "Attach To Process",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
              },
            }
          end
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
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
    {
      "mxsdev/nvim-dap-vscode-js",
    },
    {
      "mfussenegger/nvim-dap-python",
      enabled = true,
      ft = "python",
      config = function()
        local debugpy_path = require("mason-registry").get_package("debugpy"):get_install_path()
        local dap_python = require("dap-python")
        dap_python.setup(debugpy_path .. "/venv/bin/python")
        dap_python.test_runner = "pytest"
        dap_python.resolve_python = function()
          return "/Users/dlvhdr/code/komodor/mono/services/venv/bin/python"
        end
        table.insert(require("dap").configurations.python, {
          type = "python",
          request = "launch",
          name = "Test: Brain",
          module = "pytest",
          -- args = {
          --   "<path/to/test>",
          --   "-k",
          --   "<name of test function>",
          -- },
          env = {
            PYTHONPATH = "/Users/dlvhdr/code/komodor/mono/services/brain/../",
          },
        })
        table.insert(require("dap").configurations.python, {
          type = "python",
          request = "launch",
          name = "Run: Brain",
          module = "brain.consumer",
          env = {
            PYTHONPATH = "/Users/dlvhdr/code/komodor/mono/services/brain/../",
          },
        })
      end,
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
