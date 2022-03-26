local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 5 },
    { name = "emoji" },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      with_text = false,
      maxwidth = 50,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[ LSP]",
          nvim_lua = "[ Lua]",
          treesitter = "[ Treesitter]",
          path = "[ﱮ Path]",
          buffer = "[﬘ Buffer]",
          luasnip = "[ Snippet]",
        })[entry.source.name]
        return vim_item
      end,
    }),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- ["<Tab>"] = cmp.mapping(function(fallback)
--   if luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   elseif has_words_before() then
--     cmp.complete()
--   else
--     fallback()
--   end
-- end, { "i", "s" }),
-- ["<S-Tab>"] = cmp.mapping(function(fallback)
--   if luasnip.jumpable(-1) then
--     luasnip.jump(-1)
--   else
--     fallback()
--   end
-- end, { "i", "s" }),
