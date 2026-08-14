vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- Enable highlighting for all filetypes
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    -- Only start treesitter when the parser ships highlight queries; otherwise
    -- fall back to the built-in syntax highlighting
    if lang ~= nil and vim.treesitter.query.get(lang, "highlights") then
      if lang == "kulala_ui" then
        vim.cmd("TSContext disable")
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(args.buf)
      return
    end
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TSContextToggle",
    init = function()
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context()
      end, { silent = true, desc = "Go to TS context" })
      vim.keymap.set("n", "<leader>lc", function()
        require("treesitter-context").toggle()
      end, { silent = true, desc = "Treesitter Context" })

      local wk = require("which-key")
      wk.add({
        { "<leader>lc", icon = "󰨚 " },
      })
    end,
    config = function()
      local tscontext = require("treesitter-context")
      tscontext.setup({
        mode = "cursor",
        max_lines = 3,
        -- don't start by default, only when toggled on
        enable = false,
      })
      Snacks.toggle
        .new({
          id = "treesitter_context",
          name = "Treesitter Context",
          get = tscontext.enabled,
          set = function(state)
            if state then
              tscontext.enable()
            else
              tscontext.disable()
            end
          end,
        })
        :map([[\t]])
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    ft = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    event = "BufReadPre",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}
