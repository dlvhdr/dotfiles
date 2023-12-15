return {
  "andymass/vim-matchup",
  event = { "BufRead", "BufNewFile" },
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
