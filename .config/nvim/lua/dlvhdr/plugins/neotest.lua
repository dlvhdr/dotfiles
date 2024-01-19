return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-go",
    "marilari88/neotest-vitest",
    "folke/trouble.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = "Neotest",
  opts = {
    adapters = {
      ["neotest-go"] = {},
      ["neotest-vitest"] = {},
    },
    status = { virtual_text = true },
    output = { open_on_run = true },
    -- requires nvim 0.10?
    quickfix = {
      enable = true,
      open = function()
        require("trouble").open({ mode = "quickfix", focus = false })
      end,
    },
  },
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    opts.consumers = opts.consumers or {}
    -- Refresh and auto close trouble after running tests
    ---@type neotest.Consumer
    opts.consumers.trouble = function(client)
      client.listeners.results = function(adapter_id, results, partial)
        if partial then
          return
        end
        local tree = assert(client:get_position(nil, { adapter = adapter_id }))

        local failed = 0
        for pos_id, result in pairs(results) do
          if result.status == "failed" and tree:get_key(pos_id) then
            failed = failed + 1
          end
        end
        vim.schedule(function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.refresh()
            if failed == 0 then
              trouble.close()
            end
          end
        end)
        return {}
      end
    end

    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == "number" then
          if type(config) == "string" then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == "table" and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif meta and meta.__call then
              adapter(config)
            else
              error("Adapter " .. name .. " does not support setup")
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end

    require("neotest").setup(opts)
  end,
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File",
    },
    {
      "<leader>tT",
      function()
        require("neotest").run.run(vim.loop.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({
          enter = true,
          open_win = function(settings)
            local height = math.min(settings.height, vim.o.lines - 2)
            local width = math.min(settings.width, vim.o.columns - 2)
            return vim.api.nvim_open_win(0, true, {
              relative = "editor",
              row = 7,
              col = (vim.o.columns - width) / 2,
              width = width,
              height = height,
              style = "minimal",
              border = "rounded",
              noautocmd = true,
            })
          end,
        })
      end,
      desc = "Show Output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
  },
}
