local function get_git_root_fs(dir)
  local current_dir = vim.fn.fnamemodify(dir, ':p')
  while current_dir ~= '/' do
    if vim.fn.isdirectory(current_dir .. '/.git') == 1 then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
  end
  return nil
end

local actions = require('telescope.actions')

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
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
          local git_root = get_git_root_fs(opts.cwd)
          if git_root then opts.cwd = git_root end
          require("telescope.builtin").find_files(opts)
        end,
        desc = "Find project files (Telescope)",
      },
      {
        "<leader>f",
        function()
          local opts = {}
          local git_root = get_git_root_fs(opts.cwd)
          if git_root then opts.cwd = git_root end
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
    opts = {
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
      require('telescope').load_extension('ui-select')
    end
  }
}
