🏠 dlvhdr's dotfiles

💿 Nix | 👻 Ghostty | 🖥 tmux | ✍️ Neovim

![screenshot of setup](https://github.com/dlvhdr/dotfiles/assets/6196971/6f2e479b-e8e8-414c-a763-2a1e5db754f8)

## Setup

- **Terminal:** Ghostty + tmux
- **Shell:** fish + starship
- **Editor:** nvim
- **Source control:** git + gh + tig + lazygit
- **Theme:** tokyonight

## Neovim

- **Plugin manager:** lazy
- **Statue line:** lualine
- **Completions:** nvim-cmp
- **LSP:** mason, none-ls
- **Syntax highlighting:** treesitter
- **Fuzzy finder:** telescope
- **File tree:** nvim-tree
- **Snippets:** LuaSnip
- Other goodies...

## Getting Started

1. Install nix with `sh <(curl -L https://nixos.org/nix/install)`
2. Add to fish path with `fish_add_path -p /run/current-system/sw/bin`
3. Install nix-darwin with `nix run nix-darwin -- switch --flake ~/.config/nix-darwin`
4. Clone this repo with `git clone https://github.com/dlvhdr/dotfiles.git`
5. Switch: `darwin-rebuild switch --flake ~/dotfiles/nix#aarch64`
6. Login to 1Password and enable the SSH Agent under "Developer"
7. Start Raycast and import settings under `dotfiles/nix/module/raycast/backups` (the password is in 1Password under www.raycast.com -> Backup Password)

## Migration to Nix TODO

- [ ] Install gh-dash extension

---

Author: Dolev Hadar

Email: dolevc2@gmail.com
