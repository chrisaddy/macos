return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup()
    require('mini.icons').setup()
    require('mini.comment').setup()
    require('mini.completion').setup()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.bracketed').setup()
    require('mini.files').setup()
    require('mini.tabline').setup()
    require('mini.map').setup()
    require('mini.diff').setup()
    require('mini.git').setup()

    vim.keymap.set('n', '<leader>o', function()
      MiniFiles.open()
    end, { desc = '[f]ile [t]ree' })

    vim.keymap.set('n', '<leader>gh', function()
      MiniGit.show_at_cursor()
    end, { desc = '[g]it [h]istory' })

    -- require('mini.notify').setup()
    -- require('mini.snippets').setup()

    -- local gen_loader = require('mini.snippets').gen_loader
    -- require('mini.snippets').setup {
    --   snippets = {
    --     gen_loader.from_file '~/.config/nvim/snippets/global.json',
    --   },
    -- }
  end,
}
