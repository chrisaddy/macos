return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = false,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    follow_url_func = function(url)
      vim.fn.jobstart { 'open', url } -- macOS
    end,

    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = 'zettelkasten',
        path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/zettelkasten',
        overrides = {
          disable_frontmatter = true,
        },
      },
    },
    daily_notes = {
      folder = 'calendar',
      date_format = '✱ %m %B/%d %B',
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
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
    { '<leader>lf', '<cmd>ObsidianFollowLink<cr>', desc = '[L]ink [F]ollow' },
  },
}
