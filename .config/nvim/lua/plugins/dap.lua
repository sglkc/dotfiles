return {} or {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "leoluz/nvim-dap-go" },
      { "igorlfs/nvim-dap-view" },
    },
    -- shameless copy from https://github.com/RyaWcksn/nv-config/blob/master/lua/configs/dap.lua
    config = function()
      local dap = require('dap')

      dap.adapters.delve = function(callback, config)
        local ok, err = pcall(function()
          if config.mode == "remote" and config.request == "attach" then
            callback({
              type = "server",
              host = config.host or "127.0.0.1",
              port = config.port or "38697",
            })
          else
            callback({
              type = "server",
              port = "${port}",
              executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
                detached = vim.fn.has("win32") == 0,
              },
            })
          end
        end)
        if not ok then
          vim.notify("[DAP] Error setup delve adapter: " .. tostring(err), vim.log.levels.ERROR)
        end
      end

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug Workspace",
          request = "launch",
          program = "${workspaceFolder}"
        },
        {
          type = "delve",
          name = "Debug Relative",
          request = "launch",
          program = "./${relativeFileDirname}"
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        }
      }
    end
  },
}
