local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  return
end

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

local next_completion = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end

local prev_completion = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- window = {
  --   documentation = cmp.config.window.bordered(),
  -- },
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
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
    ["<C-n>"] = next_completion,
    ["<C-p>"] = prev_completion,
  }),
  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    {
      name = "luasnip",
      keyword_length = 2,
      priority = 50,
    },
    { name = "buffer", keyword_length = 3 },
  },
  formatting = {
    format = function(_, vim_item)
      local icons = lspkind.symbol_map
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
  sorting = {
    comparators = {
      cmp.config.compare.sort_text,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
    { name = "path" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
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
