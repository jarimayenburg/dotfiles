return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.summary"] = {},
      ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
      ["core.integrations.nvim-cmp"] = {},
      ["core.concealer"] = { config = { icon_preset = "diamond" } },
      ["core.export"] = {},
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          neorg_leader = "<leader><leader>",
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            work = "~/Ivido/notes",
            personal = "~/Personal/notes"
          },
          default_workspace = "work",
        },
      },
    },
  }
}
