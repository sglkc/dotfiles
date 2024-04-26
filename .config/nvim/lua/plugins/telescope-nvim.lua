local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local telescope_actions = require("telescope.actions")

telescope.setup({
  defaults = {
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
    mappings = {
      i = {
        ["<esc>"] = telescope_actions.close
      },
    },
  },
  -- extensions = {
  --   aerial = {
  --     -- Display symbols as <root>.<parent>.<symbol>
  --     show_nesting = {
  --       ['_'] = false, -- This key will be the default
  --       json = true,   -- You can set the option for specific filetypes
  --       yaml = true,
  --     }
  --   }
  -- }
})

require"telescope".load_extension('fzf')
-- require"telescope".load_extension('aerial')

-- Finds
local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then return end

local builtin = require('telescope.builtin')
local extensions = telescope.extensions

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

local project_files = function()
  local root = get_project_root()
  if root then opts = { cwd = root } end
  builtin.find_files(opts)
end

function live_grep_project()
  local root = get_project_root()
  if root then opts = { cwd = root } end
  builtin.live_grep(opts)
end

local buffers = function()
  builtin.buffers(require('telescope.themes').get_dropdown{
    previewer = false
  })
end

vim.keymap.set('n', 'ff', project_files, {})
vim.keymap.set('n', '<leader>p', project_files, {})
vim.keymap.set('n', 'fg', live_grep_project, {})
vim.keymap.set('n', '<leader>g', live_grep_project, {})
vim.keymap.set('n', 'fb', buffers, {})
vim.keymap.set('n', '<leader>b', buffers, {})

