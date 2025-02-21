return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "linrongbin16/lsp-progress.nvim",
        opts = {
          client_format = function(client_name, spinner, series_messages)
            if #series_messages == 0 then
              return nil
            end
            return {
              name = client_name,
              body = spinner .. " " .. table.concat(series_messages, ", "),
            }
          end,
          format = function(client_messages)
            --- @param name string
            --- @param msg string?
            --- @return string
            local function stringify(name, msg)
              return msg and string.format("%s %s", name, msg) or name
            end

            local sign = "" -- nf-fa-gear \uf013
            local lsp_clients = vim.lsp.get_clients()
            local messages_map = {}
            for _, climsg in ipairs(client_messages) do
              messages_map[climsg.name] = climsg.body
            end

            if #lsp_clients > 0 then
              table.sort(lsp_clients, function(a, b)
                return a.name < b.name
              end)
              local builder = {}
              for _, cli in ipairs(lsp_clients) do
                if
                  type(cli) == "table"
                  and type(cli.name) == "string"
                  and string.len(cli.name) > 0
                then
                  if messages_map[cli.name] then
                    table.insert(builder, stringify(cli.name, messages_map[cli.name]))
                  else
                    table.insert(builder, stringify(cli.name))
                  end
                end
              end
              if #builder > 0 then
                return sign .. " " .. table.concat(builder, ", ")
              end
            end
            return ""
          end,
        }
      },
    },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
    opts = function()
      return {
        options = {
          theme = "auto",
          component_separators = { left = '' , right = '' },
          disabled_filetypes = {
            statusline = {
              "dashboard", "alpha", "starter", "NvimTree", "help",
            }
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            -- { "vim.fn.expand('%:p:h:t')" },
            { "filename", newfile_status = true, shorting_target = 20 }
          },
          lualine_c = {
            { "branch", color = { fg = '#c8d3f5' }, padding = 1 },
            {
              "diff",
              diff_color = {
                added    = { fg = '#b8db87' },
                modified = { fg = '#7ca1f2' },
                removed  = { fg = '#e26a75' }
              },
              symbols = {
                added    = " ",
                modified = " ",
                removed  = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              diagnostics_color = {
                error = { fg = '#c53b53' },
                warn  = { fg = '#ffc777' },
                hint  = { fg = '#4fd6be' },
                info  = { fg = '#0db9d7' }
              },
              symbols = {
                error = " ",
                warn  = " ",
                hint  = " ",
                info  = " ",
              },
              update_in_insert = true,
            },
            function ()
              return require('lsp-progress').progress()
            end,
            -- {
            --   function()
            --     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            --     local clients = vim.lsp.get_clients()
            --
            --     if next(clients) == nil then return '-' end
            --
            --     for _, client in ipairs(clients) do
            --       local filetypes = client.config.filetypes
            --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            --         return client.name
            --       end
            --     end
            --
            --     return '-'
            --   end,
            --   color = { fg = '#c8d3f5' },
            --   icon = { '', align = 'right' },
            -- },
          },
          lualine_y = {
            -- { 'fileformat', separator = "", padding = 1 },
            { 'filetype', colored = false },
          },
          lualine_z = {
            { "location", padding = { left = 0, right = 1 } },
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
