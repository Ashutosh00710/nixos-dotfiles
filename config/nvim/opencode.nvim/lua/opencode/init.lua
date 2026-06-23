local M = {}

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.g.colors_name = "opencode"
  vim.o.termguicolors = true
  vim.o.background = "dark"

  local palette = require("opencode.palette")
  local groups = require("opencode.groups")
  groups.setup(palette.dark)
end

--- Lualine theme table (auto-detected by lualine if the colorscheme name matches)
function M.lualine()
  local p = require("opencode.palette").dark
  return {
    normal = {
      a = { fg = p.bg, bg = p.secondary, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_surface },
      c = { fg = p.fg_muted, bg = p.bg_panel },
    },
    insert = {
      a = { fg = p.bg, bg = p.green, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_surface },
      c = { fg = p.fg_muted, bg = p.bg_panel },
    },
    visual = {
      a = { fg = p.bg, bg = p.accent, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_surface },
      c = { fg = p.fg_muted, bg = p.bg_panel },
    },
    replace = {
      a = { fg = p.bg, bg = p.red, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_surface },
      c = { fg = p.fg_muted, bg = p.bg_panel },
    },
    command = {
      a = { fg = p.bg, bg = p.primary, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_surface },
      c = { fg = p.fg_muted, bg = p.bg_panel },
    },
    inactive = {
      a = { fg = p.fg_dark, bg = p.bg_panel },
      b = { fg = p.fg_dark, bg = p.bg_panel },
      c = { fg = p.fg_dark, bg = p.bg_panel },
    },
  }
end

return M
