local owls = {
  [[     (\___/)   (\___/)   (\___/)   (\___/)   (\___/)      ]],
  [[     /0\ /0\   /-\ /-\   /0\ /0\   /-\ /-\   /o\ /o\      ]],
  [[     \__V__/   \__V__/   \__V__/   \__V__/   \__V__/      ]],
  [[    /|:. .:|\ /|;, ,;|\ /|:. .:|\ /|;, ,;|\ /|;, ,;|\     ]],
  [[    \\:::::// \\;;;;;// \\:::::// \\;;;;;// \\;;;;;//     ]],
  [[--jgs`"" ""`---`"" ""`---`"" ""`---`"" ""`---`"" ""`--    ]],
  [[ ~^^~^~^~^~^^~~^^^~^~~^~^~^~^^~~^^^~^~~^~^~^~^^~~^^^~^^^  ]],
}
local apple = {
  [[                             ___]],
  [[                          _/`.-'`.]],
  [[                _      _/` .  _.']],
  [[       ..:::::.(_)   /` _.'_./]],
  [[     .oooooooooo\ \o/.-'__.'o.]],
  [[    .ooooooooo`._\_|_.'`oooooob.]],
  [[  .ooooooooooooooooooooo&&oooooob.]],
  [[ .oooooooooooooooooooo&@@@@@@oooob.]],
  [[.ooooooooooooooooooooooo&&@@@@@ooob.]],
  [[doooooooooooooooooooooooooo&@@@@ooob]],
  [[doooooooooooooooooooooooooo&@@@oooob]],
  [[dooooooooooooooooooooooooo&@@@ooooob]],
  [[dooooooooooooooooooooooooo&@@oooooob]],
  [[`dooooooooooooooooooooooooo&@ooooob']],
  [[ `doooooooooooooooooooooooooooooob']],
  [[  `doooooooooooooooooooooooooooob']],
  [[   `doooooooooooooooooooooooooob']],
  [[    `doooooooooooooooooooooooob']],
  [[     `doooooooooooooooooooooob']],
  [[jgs   `dooooooooobodoooooooob']],
  [[       `doooooooob dooooooob']],
  [[         `"""""""' `""""""']],
}

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
    local colors = require("tokyonight.colors").setup()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = apple
    dashboard.section.header.opts.hl = "Error"

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
