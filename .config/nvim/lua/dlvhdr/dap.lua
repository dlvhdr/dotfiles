local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.adapters.go = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/code/go/vscode-go/dist/debugAdapter.js" },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
  },
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

-- `DapBreakpointCondition` which defaults to `C` for conditional breakpoints
-- `DapLogPoint` which defaults to `L` and is for log-points
-- `DapStopped` which defaults to `→` and is used to indicate the position where
--  the debugee is stopped.
-- `DapBreakpointRejected`, defaults to `R` for breakpoints which the debug
-- adapter rejected.
