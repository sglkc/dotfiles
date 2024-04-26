return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "CmdlineEnter",
    config = function()
      require("nvim-surround").setup()
    end
  }
}
