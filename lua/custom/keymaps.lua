local keymap = vim.keymap

local nav = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function navigate(dir)
  return function()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(dir)
    local pane = vim.env.WEZTERM_PANE
    if pane and win == vim.api.nvim_get_current_win() then
      local pane_dir = nav[dir]
      vim.system({ 'wezterm', 'cli', 'activate-pane-direction', pane_dir }, { text = true }, function(p)
        if p.code ~= 0 then
          vim.notify('Failed to move to pane ' .. pane_dir .. '\n' .. p.stderr, vim.log.levels.ERROR, { title = 'Wezterm' })
        end
      end)
    end
  end
end

-- Move to window using the movement keys
for key, dir in pairs(nav) do
  keymap.set('n', '<' .. dir .. '>', navigate(key))
  keymap.set('n', '<C-' .. key .. '>', navigate(key))
end

keymap.set('n', '<C-c>', '<cmd>normal! ciw<cr>a')

keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })

-- window management
keymap.set('n', '<leader>s|', '<C-w>v', { desc = 'Split window vertically' }) -- split window vertically
keymap.set('n', '<leader>s-', '<C-w>s', { desc = 'Split window horizontally' }) -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window

keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab

keymap.set('n', '<leader>ll', function()
  require('lazy').show()
end, { desc = 'Lazy home' })
keymap.set('n', '<leader>lu', function()
  require('lazy').update()
end, { desc = 'Lazy update' })
keymap.set('n', '<leader>lc', function()
  require('lazy').check()
end, { desc = 'Lazy check' })
keymap.set('n', '<leader>ls', function()
  require('lazy').sync()
end, { desc = 'Lazy sync' })

keymap.set({ 'n', 'v' }, '[[', '{', { desc = 'Previous empty line' })
keymap.set({ 'n', 'v' }, ']]', '}', { desc = 'Next empty line' })

keymap.set({ 'n', 'v' }, 'gg', 'gg_')
keymap.set({ 'n', 'v' }, 'n', 'nzz')
keymap.set({ 'n', 'v' }, 'N', 'Nzz')
