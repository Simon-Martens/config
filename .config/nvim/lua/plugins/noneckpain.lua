return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    local nnp = require 'no-neck-pain'
    nnp.setup {
      width = 75,
      minSideBufferWidth = 20,
      fallbackOnBufferDelete = false,
      buffers = {
        right = {
          enabled = true,
          scratchPad = {
            enabled = true,
            pathToFile = '~/.local/share/nvim/scratch/global.md',
          },
        },
        left = {
          enabled = false,
        },
        bo = {
          filetype = 'md',
        },
        wo = {
          fillchars = 'eob: ',
        },
      },
      autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        reloadOnColorSchemeChange = true,
      },
      mappings = {
        enabled = true,
      },
    }
  end,
}
