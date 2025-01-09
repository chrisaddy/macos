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
    note_id_func = function(title)
      if title ~= nil then
        -- Replace spaces with dashes and remove invalid characters
        return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        return 'untitled'
      end
    end,
    note_path_func = function(spec)
      -- Use the title as the filename, ensure it has a `.md` suffix
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix '.md'
    end,
  },
  keys = {
    { '<leader>nn', '<cmd>ObsidianNew<cr>', desc = '[N]ote [N]ew' },
    { '<leader>ns', '<cmd>ObsidianSearch<cr>', desc = '[N]ote [S]earch' },
  },
}
