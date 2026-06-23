return {
  -- Load the opencode colorscheme plugin (local)
  {
    dir = "~/.config/nvim/opencode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme opencode")
    end,
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "opencode",
    },
  },
}
