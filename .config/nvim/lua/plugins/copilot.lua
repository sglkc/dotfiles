return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = true, -- vim.g.ai_cmp,
        keymap = {
          accept = "<S-Tab>", -- handled by nvim-cmp / blink.cmp
          -- next = "<M-]>",
          -- prev = "<M-[>",
        },
      },
      panel = { enabled = true },
      copilot_model = "gpt-4o-copilot",
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
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
      -- See Configuration section for options
    },
  },
}
