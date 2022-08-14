local opt = vim.opt
vim.cmd("let loaded_matchparen = 1")

opt.fillchars = {
  horiz = "─",
  horizup = "⏊",
  horizdown = "┳",
  vert = " ", -- "│",
  vertleft = " ", -- "┤",
  vertright = "┣",
  verthoriz = "╋",
  diff = " ",
}
opt.conceallevel = 2
opt.showmode = false
opt.laststatus = 3
opt.mouse = "a"
opt.hidden = true
opt.wildignore = opt.wildignore + { "**/coverage/*", "**/node_modules/*", "**/.git/*" }
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.number = true
opt.relativenumber = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus"
opt.shell = "zsh"
opt.enc = "utf-8"
opt.background = "dark"
opt.showtabline = 2
opt.tabstop = 2
opt.shiftwidth = 0
opt.expandtab = true
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.belloff = "all"
opt.cursorline = true
opt.updatetime = 300
opt.showmatch = true
opt.lazyredraw = true
opt.undolevels = 10000
opt.swapfile = false
opt.undofile = true
opt.autoindent = true
opt.cindent = true
opt.signcolumn = "yes"
opt.timeoutlen = 1000
opt.pumheight = 10
opt.pumwidth = 20
-- opt.pumblend = 3
opt.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal"
opt.diffopt:append("vertical") -- Show diffs in vertical splits
opt.diffopt:append("foldcolumn:0") -- Show diffs in vertical splits
opt.diffopt:append("indent-heuristic")
opt.splitright = false
opt.showmatch = false
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore
