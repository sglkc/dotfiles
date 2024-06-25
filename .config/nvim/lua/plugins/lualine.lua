return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
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
            { "vim.fn.expand('%:p:h:t')" },
            { "filename", newfile_status = true }
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
            {
              function()
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_clients()

                if next(clients) == nil then return '-' end

                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return client.name
                  end
                end

                return '-'
              end,
              color = { fg = '#c8d3f5' },
              icon = { '', align = 'right' },
            },
          },
          lualine_y = {
            { 'fileformat', separator = "", padding = 1 },
            { 'encoding', padding = { left = 0, right = 1 } },
            { 'filetype', colored = false },
          },
          lualine_z = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
