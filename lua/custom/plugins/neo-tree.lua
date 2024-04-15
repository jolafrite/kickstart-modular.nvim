return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
  },
  keys = {
    { '<leader>ee', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' } },
    { '<leader>ef', '<cmd>Neotree filesystem<CR>', { desc = 'Toggle file explorer on current file' } },
    { '<leader>ec', '<cmd>Neotree close<CR>', { desc = 'Collapse file explorer' } },
  },
  config = function()
    local neotree = require 'neo-tree'

    neotree.setup {
      close_if_last_window = true,
      sort_case_insensitive = true,
      window = {
        position = 'right',
        width = 35,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    }
  end,
}
