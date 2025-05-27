return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        hide_during_completion = true, -- vim.g.ai_cmp,
        keymap = {
          accept = "<S-Tab>", -- handled by nvim-cmp / blink.cmp
          -- next = "<M-]>",
          -- prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      copilot_model = "claude-sonnet-4",
      filetypes = {
        markdown = true,
        help = true,
      },
      -- should_attach = function(_, _)
      --   return false
      -- end
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      { "zbirenbaum/copilot.lua" }
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
          picker = {
            enabled = true,
            ui_select = true,
          },
        },
      }
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      model = "claude-sonnet-4",
      insert_at_end = true,
    },
  },
}
