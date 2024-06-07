-- Find project root using root markers
local root_markers = { "Gemfile", "package.json", ".git/" }
function _G.RunVimTest(cmd_name)
  return function()
    for _, marker in ipairs(root_markers) do
      local marker_file = vim.fn.findfile(marker, vim.fn.expand("%:p:h") .. ";")
      if #marker_file > 0 then
        vim.g["test#project_root"] = vim.fn.fnamemodify(marker_file, ":p:h")
        break
      end
      local marker_dir = vim.fn.finddir(marker, vim.fn.expand("%:p:h") .. ";")
      if #marker_dir > 0 then
        vim.g["test#project_root"] = vim.fn.fnamemodify(marker_dir, ":p:h")
        break
      end
    end

    vim.cmd(":" .. cmd_name)
  end
end

return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  keys = {
    { "<leader>tn", RunVimTest("TestNearest"), desc = "Run nearest test" },
    { "<leader>tt", RunVimTest("TestSuite"), desc = "Run the nearest test suite" },
    { "<leader>tf", RunVimTest("TestFile"), desc = "Run all tests in the current file" },
    { "<leader>tr", RunVimTest("TestLast"), desc = "Run last test again" },
  },
  config = function()
    vim.cmd("let test#strategy = 'vimux'")
    vim.cmd("let g:test#javascript#vitest#executable = 'yarn test'")
    vim.cmd("let g:test#javascript#vitest#options = 'watch'")
  end,
}
