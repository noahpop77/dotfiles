return {
  "3rd/image.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    backend = "kitty",  -- Ghostty supports Kitty protocol perfectly
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,  -- images stay visible in insert mode
        download_remote_images = true, -- fetch ![alt](url) images
        only_render_image_at_cursor = false, -- render all images
      },
      neorg = { enabled = true },  -- if you use neorg
    },
    max_width = 100,
    max_height = 12,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
  },
}
