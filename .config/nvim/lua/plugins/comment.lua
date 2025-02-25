return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = {"n", "v"}, desc = "line comment" },
      { "gb", mode = {"n", "v"}, desc = "block comment" }
    },
    config = function()
      require('Comment').setup()
    end
  }
}
