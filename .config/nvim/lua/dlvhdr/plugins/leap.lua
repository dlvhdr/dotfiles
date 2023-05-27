return {
  "ggandor/leap.nvim",
  keys = {
    { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
    { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  },
  config = function()
    require("leap").add_default_mappings()
  end,
}
