return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("flutter-tools").setup({
        flutter_path = "/Applications/flutter/bin"
      })
    end,
  },
}
