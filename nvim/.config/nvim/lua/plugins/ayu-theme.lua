return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    name = "ayu",
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = false,
        terminal = true,
        overrides = {
          ["@function"] = { fg = "#FFB454" },
          ["@function.call"] = { fg = "#FFB454" },
          ["@function.builtin"] = { fg = "#FFB454" },
          ["@method"] = { fg = "#FFB454" },
          ["@method.call"] = { fg = "#FFB454" },

          ["@keyword"] = { fg = "#FF8F40" },
          ["@keyword.function"] = { fg = "#FF8F40" },
          ["@keyword.return"] = { fg = "#FF8F40" },

          ["@variable"] = { fg = "#CBCCC6" },
          ["@variable.builtin"] = { fg = "#95E6CB" },
          ["@parameter"] = { fg = "#CBCCC6" },

          ["@string"] = { fg = "#AAD94C" },
          ["@string.special"] = { fg = "#D4BFFF" },

          ["@module"] = { fg = "#59C2FF" },
          ["@type"] = { fg = "#59C2FF" },
          ["@type.builtin"] = { fg = "#59C2FF" },

          ["@constant"] = { fg = "#D4BFFF" },
          ["@symbol"] = { fg = "#D4BFFF" },

          ["@operator"] = { fg = "#F29E74" },
          ["@punctuation.bracket"] = { fg = "#CBCCC6" },
          ["@punctuation.delimiter"] = { fg = "#CBCCC6" },

          ["@comment"] = { fg = "#5C6773", italic = true },

          ["@keyword.elixir"] = { fg = "#FF8F40" },
          ["@function.macro.elixir"] = { fg = "#FFB454" },
          ["@variable.parameter.elixir"] = { fg = "#CBCCC6" },
        },
      })

      vim.cmd.colorscheme("ayu-dark")
    end,
  },
}
