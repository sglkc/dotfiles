local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_project_root()
  local names = { '.git', 'package.json', 'composer.json' }

  for _, name in ipairs(names) do
    local path = vim.fn.finddir(name, ".;")

    if path ~= '' then
      return vim.fn.fnamemodify(path, ":h")
    end
  end

  return nil -- vim.fn.getcwd()
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      }
    },
    keys = {
      {
        "<leader>fp",
        function()
          local root = get_project_root()
          if root then opts = { cwd = root } end
          require("telescope.builtin").find_files(opts)
        end,
        "Find project files (Telescope)"
      },
      {
        "<leader>ff",
        function()
          local root = get_project_root()
          if root then opts = { cwd = root } end
          require("telescope.builtin").live_grep(opts)
        end,
        "Ripgrep project files (Telescope)"
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers(
            require('telescope.themes').get_dropdown({
              previewer = false
            })
          )
        end,
        "Find buffers (Telescope)"
      },
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "bottom" },
          sorting_strategy = "ascending",
          buffer_previewer_maker = function(filepath, bufnr, opts)
            opts = opts or {}

            filepath = vim.fn.expand(filepath)
            vim.loop.fs_stat(filepath, function(_, stat)
              if not stat then return end
              if stat.size > 10000 then
                return
              else
                require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
              end
            end)
          end,
        },
      },
      config = function(_, opts)
        require('telescope').load_extension('fzf')
        require('telescope').setup(opts)
      end
    }
  }
}
