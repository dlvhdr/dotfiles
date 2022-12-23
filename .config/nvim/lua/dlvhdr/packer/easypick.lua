local status_ok, easypick = pcall(require, "easypick")
if not status_ok then
  return
end

easypick.setup({
  pickers = {
    -- add your custom pickers here
    -- below you can find some examples of what those can look like

    -- list files inside current folder with default previewer
    {
      -- name for your custom picker, that can be invoked using :Easypick <name> (supports tab completion)
      name = "ls",
      -- the command to execute, output has to be a list of plain text entries
      command = "ls",
      -- specify your custom previwer, or use one of the easypick.previewers
      previewer = easypick.previewers.default(),
    },

    -- list files that have conflicts with diffs in preview
    {
      name = "conflicts",
      command = "git diff --name-only --diff-filter=U --relative",
      previewer = easypick.previewers.file_diff(),
    },
  },
})
