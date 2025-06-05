return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTree" },
    keys = {
      {
        '<leader>n',
        function ()
          local nvimTree = require("nvim-tree.api")
          local currentBuf = vim.api.nvim_get_current_buf()
          local currentBufFt = vim.api.nvim_get_option_value(
            "filetype",
            { buf = currentBuf }
          )
          if currentBufFt == "NvimTree" then
            nvimTree.tree.toggle()
          else
            nvimTree.tree.focus()
          end
        end
      }
    },
    -- init = function()
    --   local arg = vim.fn.argv(0)
    --   local stat = vim.uv.fs_stat(arg)
    --   local opts = {
    --     focus = true,
    --     find_file = false,
    --   }
    --   if (stat and stat.type == "directory") then
    --     require("nvim-tree.api").tree.open({
    --       path = arg, focus = false, find_file = false
    --     })
    --   elseif (arg == "") then
    --     require("nvim-tree.api").tree.open({
    --       path = vim.loop.cwd(), focus = false, find_file = false
    --     })
    --     vim.cmd([[terminal]])
    --   else
    --     return
    --   end
    -- end,
    opts = {
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function set_hl(name, opts)
          vim.api.nvim_set_hl(0, name, opts)
        end

        set_hl('NvimTreeWinSeparator', { link = 'WinSeparator' })
        set_hl('NvimTreeExecFile', { link = 'Normal' })
        set_hl('NvimTreeIndentMarker', { fg = '#c8d3f5' })
        set_hl('NvimTreeGitNew', { fg = '#bfcfff' })
        set_hl('NvimTreeGitDirty', { fg = '#ffc777' })
        set_hl('NvimTreeGitStagedIcon', { fg = '#d7ff9e' })

        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true,
            silent = true, nowait = true
          }
        end

        local mappings = {
          ["<Tab>"] = { api.tree.change_root_to_node, 'CD' },
          ["<Space>"] = { api.tree.open, 'Open' },
          ["<BS>"] = { api.tree.change_root_to_parent, 'Up' },
          ["?"] = { api.tree.toggle_help, 'Help' },
          ["ga"] = {
            function()
              local node = api.tree.get_node_under_cursor()
              local gs = node.git_status.file

              if gs == nil then
                return
                -- gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                -- or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
              end

              if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
                vim.cmd("silent !git add " .. node.absolute_path)

              elseif gs == "M " or gs == "A " then
                vim.cmd("silent !git restore --staged " .. node.absolute_path)
              end

              api.tree.reload()
            end,
            'Git add',
          },
        }

        api.config.mappings.default_on_attach(bufnr)

        for keys, mapping in pairs(mappings) do
          vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
        end
      end,
      renderer = {
        root_folder_label = function(path)
          return ".../" .. vim.fn.fnamemodify(path, ":t")
        end,
        highlight_git = "name",
        highlight_modified = "icon",
        icons = {
          modified_placement = "signcolumn",
        }
      },
      modified = {
        enable = true
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    }
  }
}
