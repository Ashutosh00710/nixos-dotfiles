-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        mirror = false, -- This puts preview on top
        prompt_position = "bottom", -- This puts the search bar at the bottom
        height = 0.9, -- Overall window height (90% of screen)
        preview_height = 0.7, -- Preview gets 70% of the window
        results_height = 0.2, -- Results get 20% of the window
      },
    },
  },
})
