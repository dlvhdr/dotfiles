return {
  "goolord/alpha-nvim",
  event = function()
    if vim.fn.argc() == 0 then
      return "VimEnter"
    end
  end,
  cmd = "Alpha",
  requires = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      [[     (\___/)   (\___/)   (\___/)   (\___/)   (\___/)      ]],
      [[     /0\ /0\   /-\ /-\   /0\ /0\   /-\ /-\   /o\ /o\      ]],
      [[     \__V__/   \__V__/   \__V__/   \__V__/   \__V__/      ]],
      [[    /|:. .:|\ /|;, ,;|\ /|:. .:|\ /|;, ,;|\ /|;, ,;|\     ]],
      [[    \\:::::// \\;;;;;// \\:::::// \\;;;;;// \\;;;;;//     ]],
      [[--jgs`"" ""`---`"" ""`---`"" ""`---`"" ""`---`"" ""`--    ]],
      [[ ~^^~^~^~^~^^~~^^^~^~~^~^~^~^^~~^^^~^~~^~^~^~^^~~^^^~^^^  ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("s", "  Last Session", "<cmd>silent lua require('persistence').load()<CR>"),
      dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert<CR>"),
      dashboard.button("q", "󰅚  Quit NVIM", "<cmd>qa<CR>"),
    }
    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      command = "set showtabline=0 | set laststatus=0",
    })
  end,
}
