return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter" },
  keys = {
    {
      "<space>cb",
      function()
        require("treesj").toggle()
      end,
      desc = "Split/Join Block",
    },
  },
  init = function()
    local wk = require("which-key")
    wk.add({
      { "<space>cb", icon = "󰨚 " },
    })
  end,
  config = function()
    local ok, tsj = pcall(require, "treesj")
    if not ok then
      return
    end

    tsj.setup({
      use_default_keymaps = false,
      check_syntax_error = true,
      max_join_length = 120,
      cursor_behavior = "hold",

      -- Notify about possible problems or not
      notify = true,
      langs = {},
    })
  end,
}
