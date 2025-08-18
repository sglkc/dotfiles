return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')

      notify.setup({
        render = "wrapped-compact",
        max_width = 50,
        timeout = 3000,
        stages = "static",
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end
      })

      vim.notify = notify
    end
  }
}
