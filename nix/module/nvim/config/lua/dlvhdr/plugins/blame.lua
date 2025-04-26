return {
  "FabijanZulj/blame.nvim",
  cmd = "BlameToggle",
  keys = {
    { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Git Blame" },
  },
  config = function()
    require("blame").setup({
      max_summary_width = 25,
      mappings = {
        commit_info = "i",
        stack_push = "<TAB>",
        stack_pop = "<BS>",
        show_commit = "<CR>",
        close = { "q" },
      },
      date_format = "%r",
      format_fn = function(line_porcelain, config, idx)
        local hash = string.sub(line_porcelain.hash, 0, 7)
        local line_with_hl = {}
        local is_commited = hash ~= "0000000"
        if is_commited then
          local summary
          if #line_porcelain.summary > config.max_summary_width then
            summary = string.sub(line_porcelain.summary, 0, config.max_summary_width - 3) .. "..."
          else
            summary = line_porcelain.summary
          end

          line_with_hl = {
            idx = idx,
            values = {
              {
                textValue = hash,
                hl = "Comment",
              },
              {
                textValue = os.date(config.date_format, line_porcelain.committer_time),
                hl = hash,
              },
              {
                textValue = line_porcelain.author:sub(0, 6),
                hl = hash,
              },
              {
                textValue = summary,
                hl = hash,
              },
            },
            format = "%s  %s  %s %s",
          }
        else
          line_with_hl = {
            idx = idx,
            values = {
              {
                textValue = "Not committed",
                hl = "Comment",
              },
            },
            format = "%s",
          }
        end
        return line_with_hl
      end,
    })
  end,
}
