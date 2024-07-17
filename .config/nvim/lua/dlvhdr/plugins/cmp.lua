local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      cmd = { "LuaSnip" },
      event = "InsertEnter",
      config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        -- luasnip.cleanup()

        luasnip.setup({
          -- -- This tells LuaSnip to remember to keep around the last snippet.
          -- -- You can jump back into it even if you move outside of the selection
          keep_roots = true,
          link_roots = false,
          link_children = true,
          --
          -- -- This one is cool cause if you have dynamic snippets, it updates as you type!
          update_events = "TextChanged,TextChangedI",
          enable_autosnippets = true,

          -- region_check_events = "CursorHold,InsertLeave",
          delete_check_events = "TextChanged",
          store_selection_keys = "<Tab>",

          ext_opts = {
            [types.choiceNode] = {
              active = { hl_group = "Error", virt_text = { { "●", "Error" } } },
            },
            [types.insertNode] = {
              active = { hl_group = "Error", virt_text = { { "●", "Error" } } },
            },
            [types.snippetNode] = {
              active = { hl_group = "Error", virt_text = { { "●", "Error" } } },
            },
          },
        })

        luasnip.filetype_extend("typescriptreact", { "typescript" })

        require("luasnip.loaders.from_vscode").load_standalone({
          path = "~/.config/nvim/lua/dlvhdr/snippets/markdown.json",
        })
        require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/dlvhdr/snippets" } })
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-path",
    "https://codeberg.org/FelipeLema/cmp-async-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
  },
}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

  local luasnip = require("luasnip")

  local bordered = require("cmp.config.window").bordered

  local next_completion = function(fallback)
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
    elseif has_words_before() then
      cmp.complete()
    end
  end

  local prev_completion = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
    elseif has_words_before() then
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
    { name = "async_path" },
  }, {
    { name = "buffer" },
  })
  for _, source in ipairs(sources) do
    source.group_index = source.group_index or 1
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noselect,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    view = {
      ---@diagnostic disable-next-line: missing-fields
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
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = sources,

    ---@diagnostic disable-next-line: missing-fields
    formatting = {
      format = function(_, item)
        local icons = require("dlvhdr.plugins.lsp.icons").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        if item.abbr and string.len(item.abbr) > 30 then
          item.abbr = string.sub(item.abbr, 1, 30) .. "…"
        end
        if item.menu and string.len(item.menu) > 30 then
          item.menu = string.sub(item.menu, 1, 30) .. "…"
        end
        return item
      end,
    },
    experimental = {
      ghost_text = false,
    },
    sorting = defaults.sorting,
    ---@diagnostic disable-next-line: missing-fields
    performance = {
      max_view_entries = 100,
      -- debounce = 200,
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
      { name = "async_path" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "async_path" },
    }, {
      { name = "cmdline" },
    }),
  })

  vim.keymap.set("s", "<BS>", "<C-O>s")
  vim.keymap.set("i", "<C-l>", function()
    require("luasnip.extras.select_choice")()
  end, { desc = "Select next snippet choice" })
end

return M
