return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup()
    vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'fg', bg = 'bg' })
    vim.cmd 'hi TreesitterContextBottom gui=underline'
  end,
}
-- vim: ts=2 sts=2 sw=2 et
