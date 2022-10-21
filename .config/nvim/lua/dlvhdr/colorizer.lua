local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup({
  filetypes = {
    "*",
    "!TelescopePrompt",
    "!TelescopeResults",
    "!help",
    "!DiffviewFiles",
  },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    names = false,
    RRGGBBAA = true,
    AARRGGBB = false,
    rgb_fn = true,
    hsl_fn = true,
    css = false,
    css_fn = false,
    mode = "background",
    tailwind = false,
    virtualtext = "■",
  },
  buftypes = {
    "*",
    "!prompt",
    "!popup",
  },
})
