-- Tabs / Tab line:
return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  config = function()
    require('barbar').setup {
      animation = false,
      auto_hide = 1,
      icons = {
        filetype = {
          enabled = false,
        },
        preset = 'default',
      },
    }
  end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}