-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'folke/todo-comments.nvim' },
      { 'rcarriga/nvim-notify' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local transform_mod = require('telescope.actions.mt').transform_mod
      local open_with_trouble = require('trouble.sources.telescope').open

      local custom_actions = transform_mod {
        open_trouble_qflist = function()
          trouble.toggle 'quickfix'
        end,
      }

      telescope.setup {
        defaults = {
          mappings = {
            n = {
              ['<C-k>'] = actions.move_selection_next,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ['<C-t>'] = open_with_trouble,
            },
            i = {
              ['<C-k>'] = actions.move_selection_next,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ['<C-t>'] = open_with_trouble,
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'notify')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local keymap = vim.keymap

      keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file in cwd' })
      keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find recent files' })
      keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Find string in cwd' })
      keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Find string under cursor in cwd' })
      keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
      keymap.set('n', '<leader>fn', '<cmd>Telescope notify<cr>', { desc = 'Find notification' })

      keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      keymap.set('n', '<leader>?', builtin.help_tags, { desc = '[S]earch [H]elp' })
      keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
