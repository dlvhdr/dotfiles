return {
  "vuki656/package-info.nvim",
  event = { "BufRead package.json" },
  opts = {
    autostart = false,
    hide_up_to_date = true,
    hide_unstable_versions = false,
    package_manager = "yarn",
  },
}
