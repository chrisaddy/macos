return {
  {
    'folke/tokyonight.nvim',
    dependencies = {
      { 'xiyaowong/transparent.nvim', lazy = true },
    },
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    lazy = true,
    init = function()
      require('transparent').setup {
        enable = true, -- Default: false
        extra_groups = { -- You can add groups to remove background
          'NormalFloat',
          'FloatBorder',
          'SignColumn',
          'VertSplit',
        },
      }
    end,
  },
}
