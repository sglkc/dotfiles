return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    ---@type opencode.Config
    opts = function()
      return {
        auto_insert = false,
        auto_reload = true,  -- Automatically reload buffers edited by opencode
        auto_focus = false,   -- Focus the opencode window after prompting
        win = {
          position = "right",
          keys = {
            term_normal = {
              "<C-c>",
              function(self)
                vim.cmd("stopinsert")
              end,
              mode = "t",
              expr = true,
              desc = "Escape to normal mode",
            },
          },
          -- See https://github.com/folke/snacks.nvim/blob/main/docs/win.md for more window options
        },
      }
    end,
    -- stylua: ignore
    keys = {
      -- opencode.nvim exposes a general, flexible API — customize it to your workflow!
      -- But here are some examples to get you started :)
      { '<leader>ot', function() require('opencode').toggle() end, desc = 'Toggle opencode', },
      { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = { 'n', 'v' }, },
      { '<leader>on', function() require('opencode').command('/new') end, desc = 'New session', },
    },
  }
}
