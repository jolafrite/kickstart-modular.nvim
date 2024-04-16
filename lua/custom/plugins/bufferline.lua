return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  keys = {
    { '<Tab>', '<Cmd>BufferLineCycleNext', desc = 'Next tab' },
    { '<S-Tab>', '<Cmd>BufferLineCyclePrev', desc = 'Previous tab' },
  },
  opts = {
    options = {
      mode = 'tabs',
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = 'slant',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
