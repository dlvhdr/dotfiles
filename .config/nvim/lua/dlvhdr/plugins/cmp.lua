local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },
}

M.config = function()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end
  local defaults = require("cmp.config.default")()

  local lspkind_status_ok, lspkind = pcall(require, "lspkind")
  if not lspkind_status_ok then
    return
  end

  lspkind.init({
    symbol_map = {
      Copilot = "",
    },
  })

  local luasnip_status_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_status_ok then
    return
  end

  local bordered = require("cmp.config.window").bordered

  local next_completion = function(fallback)
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
    else
      cmp.complete()
    end
  end

  local prev_completion = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
    else
      cmp.complete()
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

  local sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  })
  for _, source in ipairs(sources) do
    source.group_index = source.group_index or 1
  end

  cmp.setup({
    auto_brackets = {},
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    view = {
      entries = {
        follow_cursor = true,
      },
    },
    window = {
      completion = bordered(border("CmpBorder")),
      documentation = bordered(border("CmpDocBorder")),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-y>"] = cmp.mapping({
        i = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        c = function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end,
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
      ["<C-n>"] = next_completion,
      ["<C-p>"] = prev_completion,
      ["<C-c>"] = cmp.mapping.abort(),
      ["<C-e>"] = function()
        cmp.close()
        require("copilot.suggestion").accept()
      end,
    }),
    sources = sources,
    formatting = {
      format = function(_, item)
        local icons = require("dlvhdr.plugins.lsp.icons").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        if item.menu then
          item.menu = string.sub(item.menu, 1, 20)
        end
        return item
      end,
    },
    experimental = {
      ghost_text = false,
    },
    sorting = defaults.sorting,
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
end

return M
