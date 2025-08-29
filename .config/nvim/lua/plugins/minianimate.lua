return {
  {
    "nvim-mini/mini.animate",
    event = 'VeryLazy',
    version = false,
    opts = function()
      -- don't use animate when using the mouse
      local ignored_keys = {
        "<ScrollWheelUp>", "<ScrollWheelDown>", "<LeftMouse>", "<RightMouse>"
      }
      local ignore = false

      for _, key in ipairs(ignored_keys) do
        vim.keymap.set({ "", "i" }, key, function()
          ignore = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        cursor = {
          enable = false
        },
        -- Window open/close not working with transparent background
        open = {
          enable = false
        },
        close = {
          enable = false
        },
        resize = {
          timing = animate.gen_timing.cubic({ duration = 50, unit = "total" }),
          subresize = animate.gen_subresize.equal({
            predicate = function()
              if ignore then
                ignore = false
                return false
              end
              return true
            end,
          }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if ignore then
                ignore = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end
  }
}
