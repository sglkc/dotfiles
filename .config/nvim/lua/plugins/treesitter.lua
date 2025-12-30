return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- main branch (rewrite)
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    dependencies = {
      "windwp/nvim-ts-autotag",
      "RRethy/nvim-treesitter-endwise",
      "jwalton512/vim-blade",
      {
        "andymass/vim-matchup",
        lazy = false,
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
          vim.g.matchup_transmute_enabled = 1
          vim.g.matchup_delim_noskips = 1
          vim.g.matchup_delim_stopline = 1000
          vim.g.matchup_matchparen_stopline = 200
          vim.g.matchup_matchparen_timeout = 100
          vim.g.matchup_matchparen_insert_timeout = 60
          vim.g.matchup_matchparen_deferred = 1
          vim.g.matchup_matchparen_deferred_show_delay = 50
          vim.g.matchup_matchparen_deferred_hide_delay = 300
          vim.g.matchup_matchparen_pumvisible = 0

          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.event:on("menu_opened", function()
              vim.b.matchup_matchparen_enabled = false
            end)
            cmp.event:on("menu_closed", function()
              vim.b.matchup_matchparen_enabled = true
            end)
          end
        end,
      },
    },

    opts = {
      ensure_installed = {
        "bash",
        "python",
        "html", "css",
        "javascript", "jsdoc",
        "typescript", "tsx",
        "astro", "vue",
        "php", "phpdoc",
        "sql",
        "json", "jsonc", "markdown", "markdown_inline",
        "query", "regex",
        "lua", "vim", "vimdoc", "toml", "yaml",
      },
    },

    config = function(_, opts)
      local ts = require("nvim-treesitter")

      -- 1. Install parsers (rewrite API)
      ts.install(opts.ensure_installed)

      -- 2. Blade parser (unchanged, still valid)
      local parsers = require("nvim-treesitter.parsers")
      parsers.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      -- 3. Feature plugins
      require("nvim-ts-autotag").setup()

      -- 4. Treesitter activation (NEW REQUIRED STEP)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local buf = args.buf
          local max_filesize = 1000 * 1024 -- ~1MB

          local ok, stat = pcall(
            vim.loop.fs_stat,
            vim.api.nvim_buf_get_name(buf)
          )

          if ok and stat and stat.size > max_filesize then
            return
          end

          pcall(vim.treesitter.start, buf)
        end,
      })
    end,
  },
}

