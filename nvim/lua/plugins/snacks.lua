return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {
      win = {
        style = 'floating',
        opts = {
          width = 0.8,
          height = 0.8,
          border = 'rounded',
        },
      },
      ---@type table<string, snacks.win.Config>
      styles = {
        position = 'float',
      },
      cmd = { vim.o.shell },
    },
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
      '<C-\\>',
      function()
        require('snacks.terminal').toggle()
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
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
