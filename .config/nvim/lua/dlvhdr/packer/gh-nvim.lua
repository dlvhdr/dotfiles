-- local lib_status_ok, litee_lib = pcall(require, "litee.lib")
-- if not lib_status_ok then
--   return
-- end

-- local gh_status_ok, litee_gh = pcall(require, "litee.gh")
-- if not gh_status_ok then
--   return
-- end

require("litee.lib").setup({
  tree = {
    icon_set = "nerd",
  },
  panel = {
    orientation = "right",
    panel_size = 35,
  },
})

require("litee.gh").setup({ icon_set = "nerd" })

require("lunamark")
