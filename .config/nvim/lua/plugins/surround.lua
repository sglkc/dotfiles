return {
  {
    "kylechui/nvim-surround",
    version = "*",
    keys = {
      { "ys", desc = "add surround" },
      { "cs", desc = "change surround" },
      { "ds", desc = "delete surround" },
    },
    config = function()
      require("nvim-surround").setup()
    end
  }
}
