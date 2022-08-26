local lib_status_ok, litee_lib = pcall(require, "litee.lib")
if not lib_status_ok then
  return
end

local gh_status_ok, litee_gh = pcall(require, "gh")
if not gh_status_ok then
  return
end

litee_lib.setup()
litee_gh.setup({
  icon_set = "nerd",
  prefer_https_remote = true,
})
