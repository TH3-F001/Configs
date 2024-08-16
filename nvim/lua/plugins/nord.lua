return {
  "gbprod/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nord")
    vim.cmd.colorscheme("nord")
  end,
}
