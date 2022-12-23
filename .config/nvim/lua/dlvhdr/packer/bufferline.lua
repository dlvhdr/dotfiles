local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    max_name_length = 100,
    custom_filter = function()
      return true
    end,
    name_formatter = function(buf)
      return vim.fn.fnamemodify(buf.name, ":p:gs?Users/dolevh/code/wix/??:gs?^/??:gs?Users/dolevh?~?")
    end,
  },
})
