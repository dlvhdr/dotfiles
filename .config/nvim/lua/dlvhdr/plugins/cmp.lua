local M = {
  "hrsh7th/nvim-cmp",
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

  vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

  local next_completion = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    else
      cmp.complete()
    end
  end

  local prev_completion = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
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

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
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
    sources = {
      { name = "nvim_lsp", group_index = 2, max_item_count = 80 },
      {
        name = "luasnip",
        keyword_length = 2,
        priority = 50,
        max_item_count = 2,
        group_index = 2,
      },
      { name = "buffer", group_index = 3, keyword_length = 3 },
    },
    formatting = {
      format = function(_, vim_item)
        local icons = lspkind.symbol_map

        vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
        return vim_item
      end,
    },
    experimental = {
      ghost_text = false,
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
end

return M
