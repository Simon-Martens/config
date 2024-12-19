-- Shows a global buffer on the right side of the screen
-- so the text doesnt get too wide and hard to read.
return {
  'shortcuts/no-neck-pain.nvim',
  config = function()
    local nnp = require 'no-neck-pain'
    nnp.setup {
      width = 80,
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
