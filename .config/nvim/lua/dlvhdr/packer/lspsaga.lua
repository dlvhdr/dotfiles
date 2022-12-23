local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
  return
end

lspsaga.init_lsp_saga({
  max_preview_lines = 10,
  code_action_icon = " ",
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = false,
  },
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "<esc>",
    exec = "<CR>",
  },
  rename_action_quit = "<esc>",
  border_style = "rounded",
  server_filetype_map = {},
})
