local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
    },
    keys = {
      {
        "<leader>.",
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.expand('%:p:h') })
        end,
        desc = "Find files from current directory (Telescope)",
      },
      {
        "<leader>p",
        function()
          local opts = {}
          if is_git_repo() then opts.cwd = get_git_root() end
          require("telescope.builtin").find_files(opts)
        end,
        desc = "Find project files (Telescope)",
      },
      {
        "<leader>f",
        function()
          local opts = {}
          if is_git_repo() then opts.cwd = get_git_root() end
          require("telescope.builtin").live_grep(opts)
        end,
        desc = "Ripgrep project files (Telescope)",
      },
      {
        "<leader>b",
        function() require("telescope.builtin").buffers() end,
        desc = "Find buffers (Telescope)",
      },
    },
    config = function()
      local actions = require('telescope.actions')
      local opts = {
        defaults = {
          path_display = {
            shorten = 5,
            truncate = 3
          },
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--trim", "--hidden",
            "-g", "!**/.git/*", "-g", "!**/public/*", "-g", "!**/*.min.*"
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close
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
        }
      }

      require('telescope').load_extension('fzf')
      -- require('telescope').load_extension('ui-select')
      require('telescope').setup(opts)
    end
  }
}
