# yatline-modified-time.yazi

An addon to display the modification time of file or folder in your [yatline.yazi](https://github.com/imsi32/yatline.yazi).

## Requirements

- [yazi](https://github.com/sxyazi/yazi) version >= 0.4.0
- [yatline.yazi](https://github.com/imsi32/yatline.yazi)

## Installation

```sh
ya pkg add wekauwau/yatline-modified-time
```

## Usage

> [!IMPORTANT]
> Add this to your `~/.config/yazi/init.lua` after yatline.yazi's initialization.

```lua
require("yatline-modified-time"):setup()
```

Then, add it in one of your sections in the yatline configuration using:

```lua
{ type = "coloreds", custom = false, name = "modified-time" }
```

## Credits

- [Yazi](https://github.com/sxyazi/yazi)
- [yatline.yazi](https://github.com/imsi32/yatline.yazi)
- [yatline-symlink.yazi](https://github.com/lpanebr/yazi-plugins/tree/main/yatline-symlink.yazi)
