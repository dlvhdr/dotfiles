local opt = vim.opt
vim.cmd("let loaded_matchparen = 1")

local function list(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({ value, str }, sep) or value
end

opt.helpheight = 30
opt.fillchars = {
  horiz = "─",
  horizup = "⏊",
  horizdown = "┳",
  vert = "🭵", -- "│",
  vertleft = " ", -- "┤",
  vertright = "┣",
  verthoriz = "╋",
  diff = "╱",
  eob = " ",
  foldclose = "",
  foldopen = "",
  msgsep = "─",
}
opt.conceallevel = 1
opt.showmode = false
opt.laststatus = 3
opt.mouse = "a"
opt.hidden = true
opt.shortmess = "filnxtToOFIAS"
opt.wildignore = opt.wildignore + { "**/coverage/*", "**/node_modules/*", "**/.git/*" }
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.number = true
opt.relativenumber = false
opt.scrolloff = 8
opt.virtualedit = list({ "block" })
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus"
opt.shell = "zsh"
opt.enc = "utf-8"
opt.background = "dark"
opt.showtabline = 1
opt.tabstop = 2
opt.softtabstop = -1
opt.shiftwidth = 2
opt.expandtab = true
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.belloff = "all"
opt.cursorline = true
opt.updatetime = 1000
opt.foldcolumn = "0"
opt.foldlevel = 0
opt.foldlevelstart = 99 --open all folds by default
opt.foldmethod = "expr"
opt.foldexpr = vim.treesitter.foldexpr
opt.foldnestmax = 1 -- maximum fold depth
opt.showmatch = true
-- ot.lazyredraw = true
opt.undolevels = 10000
opt.swapfile = false
opt.undofile = true
opt.autoindent = true
opt.cindent = true
opt.signcolumn = "yes"
opt.timeoutlen = 1000
opt.pumheight = 10
opt.pumwidth = 20
opt.cmdheight = 0
-- opt.pumblend = 3
opt.sessionoptions = "blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal"
-- opt.diffopt:append("vertical") -- Show diffs in vertical splits
-- opt.diffopt:append("foldcolumn:0") -- Show diffs in vertical splits
-- opt.diffopt:append("indent-heuristic")
opt.diffopt = list({
  "algorithm:histogram",
  "internal",
  "indent-heuristic",
  "filler",
  "closeoff",
  "iwhite",
  "vertical",
})
opt.splitright = false
opt.splitbelow = true
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
if vim.fn.executable("rg") then
  -- if ripgrep installed, use that as a grepper
  opt.grepprg = "rg --vimgrep --no-heading"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
