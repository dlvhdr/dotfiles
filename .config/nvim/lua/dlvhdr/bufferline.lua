require("bufferline").setup({
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    max_name_length = 100,
    custom_filter = function(buf_number)
      return true
    end,
    name_formatter = function(buf)
      return vim.fn.fnamemodify(buf.name, ":p:gs?Users/dolevh/code/wix/??:gs?^/??:gs?Users/dolevh?~?")
    end,
  },
})
