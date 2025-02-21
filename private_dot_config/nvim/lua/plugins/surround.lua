return {
  {
    "kylechui/nvim-surround",
    version = "*",
    keys = {
      { "ys", desc = "add surround" },
      { "cs", desc = "change surround" },
      { "ds", desc = "delete surround" },
      { "S", mode = "v", desc = "add surround (visual)" }
    },
    config = function()
      require("nvim-surround").setup()
    end
  }
}
