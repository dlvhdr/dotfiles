# yatline-tokyo-night.yazi

Tokyo Night for Yatline

## Requirements

- [yazi](https://github.com/sxyazi/yazi) version >= 0.3.0
- [yatline.yazi](https://github.com/imsi32/yatline.yazi)

## Installation

```sh
ya pkg add wekauwau/yatline-tokyo-night
```

## Usage

> [!IMPORTANT]
> Add this to your `~/.config/yazi/init.lua` before Yatline's initialization.

```lua
local tokyo_night_theme = require("yatline-tokyo-night"):setup("night") -- or moon/storm/day
```

Then use the `theme` variable in Yatline config's theme parameter.

```lua
require("yatline"):setup({
-- ===

 theme = tokyo_night_theme,

-- ===
})
```

## Credits

- [yatline-catppuccin.yazi](https://github.com/imsi32/yatline-catppuccin.yazi)
- [yatline-gruvbox.yazi](https://github.com/imsi32/yatline-gruvbox.yazi)
