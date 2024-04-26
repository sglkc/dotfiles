return {
  {
    "numToStr/Comment.nvim",
    event = "ModeChanged *:[vV\x16]",
    keys = {
      { "gc", desc = "line comment" },
      { "gb", desc = "block comment" }
    },
    config = function()
      require('Comment').setup()
    end
  }
}
