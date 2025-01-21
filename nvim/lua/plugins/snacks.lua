return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader>tz',
      function()
        Snacks.zen()
      end,
      desc = '[t]oggle [z]en mode',
    },
    {
      '<leader>t.',
      function()
        Snacks.scratch()
      end,
      desc = '[t]oggle scratch buffer',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[b]uffer [d]elete',
    },

    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<c-m>',
      function()
        Snacks.terminal()
      end,
      desc = 'toggle terminal',
    },

    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
}
