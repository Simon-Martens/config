return {
  'willothy/nvim-cokeline',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for v0.4.0+
    'nvim-tree/nvim-web-devicons', -- If you want devicons
    'stevearc/resession.nvim', -- Optional, for persistent history
  },
  config = function()
    local get_hex = require('cokeline.hlgroups').get_hl_attr
    require('cokeline').setup {
      show_if_buffers_are_at_least = 1,

      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('ColorColumn', 'bg') or get_hex('Normal', 'fg')
        end,
        bg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('ColorColumn', 'bg')
        end,
      },

      components = {
        {
          text = function(buffer)
            return ' ' .. buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = get_hex('Comment', 'fg'),
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. ' '
          end,
          underline = function(buffer)
            return buffer.is_hovered and not buffer.is_focused
          end,
        },
        {
          text = ' ',
        },
      },

      tabs = {
        placement = 'right',
        components = {
          {
            text = function(tab)
              return ' ' .. tab.number .. ' '
            end,
            fg = function(tab)
              return tab.is_active and get_hex('Normal', 'fg') or get_hex('Comment', 'fg')
            end,
            bold = function(tab)
              return tab.is_active
            end,
          },
        },
      },
    }

    -- Mappings
    local map = vim.api.nvim_set_keymap

    -- Move to previous/next / Buffer / Tabs
    map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })

    -- Goto buffer in position... // We dont really need this
    for i = 1, 9 do
      map('n', ('<F%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
      map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
    end
  end,
}
