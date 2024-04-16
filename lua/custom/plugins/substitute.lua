return {
  'gbprod/substitute.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local substitute = require 'substitute'

    substitute.setup {
      on_substitute = require('yanky.integration').substitute(),
    }

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', 's', substitute.operator, { desc = 'Substitute with motion' })
    keymap.set('n', 'ss', substitute.line, { desc = 'Substitute line' })
    keymap.set('n', 'S', substitute.eol, { desc = 'Substitute to end of line' })
    keymap.set('x', 's', substitute.visual, { desc = 'Substitute in visual mode' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et
