return {
  "jackMort/ChatGPT.nvim",
  cmd = "ChatGPT",
  config = function()
    require("chatgpt").setup({
      api_key_cmd = "cat $HOME/.openai",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
