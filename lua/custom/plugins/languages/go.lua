return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',
      })
    end,

    -- vim.api.nvim_buf_create_user_command(
    --   0,
    --   'JsonToStruct',
    --   ---params args table
    --   function(args)
    --     local range = args.line1 .. ',' .. args.line2
    --     local fname = vim.api.nvim_buf_get_name(0)
    --     local cmd = { '!json-to-struct' }
    --   end,
    --   opts
    -- ),
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
