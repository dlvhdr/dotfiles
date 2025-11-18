return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-treesitter",
    "folke/tokyonight.nvim",
    "folke/which-key.nvim",
  },
  cmd = "Octo",
  config = function()
    local octo = require("octo")

    vim.treesitter.language.register("markdown", "octo")

    octo.setup({
      picker = "snacks",
      enable_builtin = true,
      mappings = {
        issue = {
          close_issue = { lhs = "<space>oic", desc = "close issue" },
          reopen_issue = { lhs = "<space>oio", desc = "reopen issue" },
          list_issues = { lhs = "<space>oil", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload issue" },
          open_in_browser = { lhs = "<leader>oo", desc = "open issue in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          add_assignee = { lhs = "<space>oaa", desc = "add assignee" },
          remove_assignee = { lhs = "<space>oad", desc = "remove assignee" },
          create_label = { lhs = "<space>olc", desc = "create label" },
          add_label = { lhs = "<space>ola", desc = "add label" },
          remove_label = { lhs = "<space>old", desc = "remove label" },
          goto_issue = { lhs = "<space>ogi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<space>oca", desc = "add comment" },
          delete_comment = { lhs = "<space>ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<space>orp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>orh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>ore", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>or+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>or-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>orr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<space>orc", desc = "add/remove 😕 reaction" },
        },
        pull_request = {
          checkout_pr = { lhs = "<space>opo", desc = "checkout PR" },
          merge_pr = { lhs = "<space>opm", desc = "merge commit PR" },
          squash_and_merge_pr = { lhs = "<space>opsm", desc = "squash and merge PR" },
          list_commits = { lhs = "<space>opc", desc = "list PR commits" },
          list_changed_files = { lhs = "<space>opf", desc = "list PR changed files" },
          show_pr_diff = { lhs = "<space>opd", desc = "show PR diff" },
          add_reviewer = { lhs = "<space>ova", desc = "add reviewer" },
          remove_reviewer = { lhs = "<space>ovd", desc = "remove reviewer request" },
          close_issue = { lhs = "<space>oic", desc = "close PR" },
          reopen_issue = { lhs = "<space>oio", desc = "reopen PR" },
          list_issues = { lhs = "<space>oil", desc = "list open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "reload PR" },
          open_in_browser = { lhs = "<space>oo", desc = "open PR in browser" },
          copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
          goto_file = { lhs = "gf", desc = "go to file" },
          add_assignee = { lhs = "<space>oaa", desc = "add assignee" },
          remove_assignee = { lhs = "<space>oad", desc = "remove assignee" },
          create_label = { lhs = "<space>olc", desc = "create label" },
          add_label = { lhs = "<space>ola", desc = "add label" },
          remove_label = { lhs = "<space>old", desc = "remove label" },
          goto_issue = { lhs = "<space>ogi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<space>oca", desc = "add comment" },
          delete_comment = { lhs = "<space>ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          react_hooray = { lhs = "<space>oRp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>oRh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>oRe", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>oR+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>oR-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>oRr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>oRl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<space>oRc", desc = "add/remove 😕 reaction" },
          review_start = { lhs = "<space>ors", desc = "start a review for the current PR" },
        },
        review_thread = {
          goto_issue = { lhs = "<space>ogi", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<space>oca", desc = "add comment" },
          add_suggestion = { lhs = "<space>osa", desc = "add suggestion" },
          delete_comment = { lhs = "<space>ocd", desc = "delete comment" },
          next_comment = { lhs = "]c", desc = "go to next comment" },
          prev_comment = { lhs = "[c", desc = "go to previous comment" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          react_hooray = { lhs = "<space>orp", desc = "add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>orh", desc = "add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>ore", desc = "add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>or+", desc = "add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>or-", desc = "add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>orr", desc = "add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>orl", desc = "add/remove 😄 reaction" },
          react_confused = { lhs = "<space>orc", desc = "add/remove 😕 reaction" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "approve review" },
          comment_review = { lhs = "<C-m>", desc = "comment review" },
          request_changes = { lhs = "<C-r>", desc = "request changes review" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        },
        review_diff = {
          add_review_comment = { lhs = "<space>oca", desc = "add a new review comment" },
          add_review_suggestion = { lhs = "<space>osa", desc = "add a new review suggestion" },
          focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
          next_thread = { lhs = "]t", desc = "move to next thread" },
          prev_thread = { lhs = "[t", desc = "move to previous thread" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader><space>o", desc = "toggle viewer viewed state" },
          submit_review = { lhs = "<leader>oS", desc = "submit review" },
        },
        file_panel = {
          next_entry = { lhs = "j", desc = "move to next changed file" },
          prev_entry = { lhs = "k", desc = "move to previous changed file" },
          select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
          refresh_files = { lhs = "R", desc = "refresh changed files panel" },
          focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
          select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          toggle_viewed = { lhs = "<leader><space>o", desc = "toggle viewer viewed state" },
        },
      },
    })

    local wk = require("which-key")

    -- Main Octo buffer
    local function attach_octo(bufnr)
      wk.add({
        { "<leader>o", buffer = bufnr, icon = " ", group = "Octo", nowait = false, remap = false },
        { "<leader>oR", buffer = bufnr, group = "Reaction", nowait = false, remap = false },
        { "<leader>oa", buffer = bufnr, group = "Assignee", nowait = false, remap = false },
        { "<leader>oc", buffer = bufnr, group = "Comment", nowait = false, remap = false },
        { "<leader>og", buffer = bufnr, group = "Go To", nowait = false, remap = false },
        { "<leader>oi", buffer = bufnr, group = "Issue", nowait = false, remap = false },
        { "<leader>ol", buffer = bufnr, group = "Label", nowait = false, remap = false },
        {
          "<leader>oo",
          "<cmd>Octo pr browser<CR>",
          buffer = bufnr,
          desc = "Open in browser",
          nowait = false,
          remap = false,
        },
        { "<leader>op", buffer = bufnr, group = "Pull Request", nowait = false, remap = false },
        { "<leader>opM", buffer = bufnr, group = "Merge", nowait = false, remap = false },
        { "<leader>opm", buffer = bufnr, group = "Manage pull request", nowait = false, remap = false },
        {
          "<leader>opr",
          "<cmd>Octo pr ready<CR>",
          buffer = bufnr,
          desc = "mark draft as ready to review",
          nowait = false,
          remap = false,
        },
        {
          "<leader>ops",
          "<cmd>Octo pr checks<CR>",
          buffer = bufnr,
          desc = "status of all checks",
          nowait = false,
          remap = false,
        },
        { "<leader>or", buffer = bufnr, group = "Review", nowait = false, remap = false },
        { "<leader>orm", buffer = bufnr, group = "Manage review", nowait = false, remap = false },
        {
          "<leader>ormc",
          "<cmd>Octo review comments<CR>",
          buffer = bufnr,
          desc = "view pending comments",
          nowait = false,
          remap = false,
        },
        {
          "<leader>ormd",
          "<cmd>Octo review discard<CR>",
          buffer = bufnr,
          desc = "delete pending review",
          nowait = false,
          remap = false,
        },
        {
          "<leader>ormp",
          "<cmd>Octo review commit<CR>",
          buffer = bufnr,
          desc = "pick a commit",
          nowait = false,
          remap = false,
        },
        {
          "<leader>orms",
          "<cmd>Octo review submit<CR>",
          buffer = bufnr,
          desc = "submit review",
          nowait = false,
          remap = false,
        },
        {
          "<leader>orr",
          "<cmd>Octo review resume<CR>",
          buffer = bufnr,
          desc = "resume",
          nowait = false,
          remap = false,
        },
        {
          "<leader>ors",
          "<cmd>Octo review start<CR>",
          buffer = bufnr,
          desc = "start review",
          nowait = false,
          remap = false,
        },
        { "<leader>os", buffer = bufnr, group = "Submit", nowait = false, remap = false },
        { "<leader>ov", buffer = bufnr, group = "Reviewer", nowait = false, remap = false },
      })
    end

    -- Review buffer
    local function attach_conf(bufnr)
      wk.add({
        { "<leader>o", buffer = bufnr, group = " Octo", nowait = false, remap = false },
        { "<leader>oc", desc = "Comment", buffer = bufnr },
        { "<leader>os", desc = "Suggestion", buffer = bufnr },
        { "<leader>oS", desc = "Submit Review", buffer = bufnr },
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "octo",
      callback = function()
        attach_octo(0)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "conf",
      callback = function()
        attach_conf(0)
      end,
    })
  end,
}
