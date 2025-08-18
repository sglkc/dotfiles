local actions = require('telescope.actions')

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        'DrKJeff16/project.nvim',
        opts = {
          silent_chdir = true,
          patterns = {
            "Makefile", "go.mod", "pyproject.toml",
            "composer.json", "package.json", "node_modules",
            ".git",
          },
        },
        config = function(_, opts)
          require('project').setup(opts)
        end
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    keys = {
      {
        "<leader>.",
        function() pcall(require("telescope").extensions.projects.projects) end,
        desc = "Find files from current directory (Telescope)",
      },
      {
        "<leader>p",
        require("telescope.builtin").find_files,
        desc = "Find project files (Telescope)",
      },
      {
        "<leader>f",
        require("telescope.builtin").live_grep,
        desc = "Ripgrep project files (Telescope)",
      },
      {
        "<leader>b",
        require("telescope.builtin").buffers,
        desc = "Find buffers (Telescope)",
      },
    },
    opts = {
      defaults = {
        path_display = {
          shorten = 10,
          truncate = 5
        },
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case", "--trim", "--hidden",
          "-g", "!**/.git/*", "-g", "!**/public/*", "-g", "!**/*.min.*"
        },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-w>"] = actions.move_selection_previous,
            ["<C-s>"] = actions.move_selection_next,
          }
        },
        preview = {
          filesize_limit = 0.5, -- MB
          highlight_limit = 0.1,
          treesitter = false,
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            }
          }
        },
        find_files = {
          find_command = {
            "rg", "--files", "--hidden", "--glob", "!**/.git/*"
          },
        }
      },
      extensions = {
        ["ui-select"] = {
          require('telescope.themes').get_dropdown({
            -- layout_config = {
            --   width = 60,
            --   height = 15
            -- },
          })
        },
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
      require('telescope').load_extension('fzf')
      require("telescope").load_extension('projects')
      require('telescope').load_extension('ui-select')
    end
  }
}
