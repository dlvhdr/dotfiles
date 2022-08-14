local status_ok, auto_save = pcall(require, "auto-save")
if not status_ok then
  return
end

auto_save.setup({
  trigger_events = { "FocusLost" },
  write_all_buffers = true,
})
