return {
  {
    "saghen/blink.cmp",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
    dependencies = {
      {
        "saghen/blink.compat",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {},
      },
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
      {
        "luckasRanarison/tailwind-tools.nvim",
        event = "LspAttach",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-telescope/telescope.nvim",
          "neovim/nvim-lspconfig",
        },
        opts = {}, -- your configuration
      },
      -- "onsails/lspkind-nvim",
      -- "zbirenbaum/copilot.lua",
      -- "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      opts.appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      }

      opts.completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            gap = 2,
            columns = {
              { "kind_icon", gap = 1 },
              { "label", "label_description", gap = 1 },
              { "source_name", gap = 1 },
            },
            components = {
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
              },
              kind_icon = {
                text = function(ctx)
                  if require("blink.cmp.completion.windows.render.tailwind").get_hex_color(ctx.item) then
                    return "󱓻"
                  end
                  local client = vim.lsp.get_client_by_id(ctx.item.client_id)
                  if client and client.name == "tailwindcss" then
                    return "󱏿"
                  end
                  return ctx.kind_icon .. ctx.icon_gap
                end,
              },
            },
          },
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        documentation = {
          window = {
            border = "rounded",
            winblend = 0,
          },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      }

      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer", "luasnip", "lazydev" },
        providers = {
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            score_offset = 90, -- the higher the number, the higher the priority
          },
          luasnip = {
            name = "luasnip",
            enabled = true,
            module = "blink.cmp.sources.luasnip",
            min_keyword_length = 2,
            fallbacks = { "snippets" },
            score_offset = 80,
            max_items = 8,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "luasnip", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 4,
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.snippets",
            min_keyword_length = 4,
            score_offset = 80, -- the higher the number, the higher the priority
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
        -- command line completion, thanks to dpetka2001 in reddit
        -- https://www.reddit.com/r/neovim/comments/1hjjf21/comment/m37fe4d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        cmdline = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" then
            return { "cmdline" }
          end
          return {}
        end,
      })

      -- This comes from the luasnip extra, if you don't add it, won't be able to
      -- jump forward or backward in luasnip snippets
      -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
      opts.snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      }

      opts.keymap = {
        preset = "default",
        ["<C-y>"] = { "select_and_accept" },

        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
      }

      return opts
    end,
  },
}
