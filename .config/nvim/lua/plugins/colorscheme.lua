return {
  {
    "folke/tokyonight.nvim",
    dependencies = {
      {
        "xiyaowong/transparent.nvim",
        lazy = false,
        priority = 500,
        opts = {
          extra_groups = {
            'NeoTreeNormal', 'NeoTreeNormalNC'
          },
          exclude_groups = {
            'CursorLine', 'CursorLineNr', 'Todo'
          }
        }
      }
    },
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      -- hide_inactive_statusline = true,
      lualine_bold = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent"
      },
      on_highlights = function(hl, c)
        hl.LineNr = { fg='#485f72' }
        hl.CursorLineNr = { link='CursorLine' }
        hl.LineNrAbove = { fg='#848cba' }
        hl.LineNrBelow = { link='LineNrAbove' }
        hl.WinSeparator = { fg='#505c5c' }
        hl.Search = { bg='#ffcb8b', fg='#112630' }
        hl.DiagnosticUnnecessary = { link='Comment' }
      end
    },
    config = function (_, opts)
      require("tokyonight").load(opts)
      vim.g.border_style = 'single'
    end
  },
}
