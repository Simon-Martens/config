return {
  'folke/snacks.nvim',
  keys = {
    {
      '<leader>.',
      function()
        local snack = require 'snacks'
        snack.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        local snack = require 'snacks'
        snack.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
  },
  opts = {
    scratch = {
      autowrite = true,
      ft = 'md',
      filekey = {
        cwd = true,
        branch = false,
        count = true,
      },
    },
  },
}
