return {
  {
    "numToStr/Comment.nvim",
    event = "ModeChanged *:[vV\x16]",
    keys = {
      { "gcc", desc = "line comment" },
      { "gbc", desc = "block comment" }
    },
    config = function()
      require('Comment').setup()
    end
  }
}
