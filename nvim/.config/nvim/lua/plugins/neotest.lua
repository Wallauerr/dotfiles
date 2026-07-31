-- Find the paired test/source file for the current buffer.
-- Elixir: lib/foo.ex <-> test/foo_test.exs
-- TypeScript/JavaScript: foo.ts <-> foo.test.ts (or .spec.)
local function alt_file()
  local path = vim.fn.expand("%:p")

  if path:match("/test/.+_test%.exs$") then
    return path:gsub("/test/", "/lib/"):gsub("_test%.exs$", ".ex")
  elseif path:match("/lib/.+%.ex$") then
    return path:gsub("/lib/", "/test/"):gsub("%.ex$", "_test.exs")
  end

  if path:match("%.test%.%w+$") then
    return path:gsub("%.test%.", ".")
  elseif path:match("%.spec%.%w+$") then
    return path:gsub("%.spec%.", ".")
  elseif path:match("%.([jt]sx?)$") then
    return path:gsub("%.([jt]sx?)$", ".test.%1")
  end
end

local function open_alt(split_cmd)
  local target = alt_file()
  if not target then
    vim.notify("No paired test/source file found", vim.log.levels.WARN)
    return
  end
  vim.cmd(split_cmd .. " " .. vim.fn.fnameescape(target))
end

local function test_runner_cmd()
  if vim.bo.filetype == "elixir" then
    return "mix test"
  elseif vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, vim.bo.filetype) then
    return "vitest run"
  end
  return "mix test"
end

-- Run the nearest test in a terminal so IO.puts/log output is visible
local function debug_nearest()
  local file = vim.fn.expand("%")
  local cmd = test_runner_cmd()
  if cmd == "mix test" then
    cmd = cmd .. " " .. vim.fn.fnameescape(file) .. ":" .. vim.fn.line(".")
  else
    cmd = cmd .. " " .. vim.fn.fnameescape(file)
  end
  vim.cmd("botright split")
  vim.cmd("terminal " .. cmd)
  vim.cmd("startinsert")
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
    keys = {
      { "<leader>t", "", desc = "+Tests" },
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Nearest Test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File Tests" },
      { "<leader>tv", function() open_alt("vsplit") end, desc = "Open Test File (vsplit)" },
      { "<leader>td", debug_nearest, desc = "Run Nearest in Terminal (shows output)" },
    },
  },
  {
    "folke/which-key.nvim",
    opts_extend = { "spec" },
    opts = {
      spec = {
        { "<leader>t", group = "Tests", icon = { icon = "󰙨 ", color = "red" } },
      },
    },
  },
}
