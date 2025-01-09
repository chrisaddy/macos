return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = 'personal',
        path = '~/Documents/addy-vault',
      },
    },
    daily_notes = {
      folder = 'daily',
    },
  },
  keys = {
    { '<leader>nn', '<cmd>ObsidianNew<cr>', desc = '[N]ote [N]ew' },
    { '<leader>ns', '<cmd>ObsidianSearch<cr>', desc = '[N]ote [S]earch' },
  },
}
