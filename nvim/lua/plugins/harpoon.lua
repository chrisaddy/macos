return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      -- REQUIRED
      harpoon:setup()

      -- Create highlight groups for the tabline
      vim.api.nvim_set_hl(0, 'HarpoonInactive', { fg = '#63698c' })
      vim.api.nvim_set_hl(0, 'HarpoonActive', { fg = '#eeeeee', bold = true })
      vim.api.nvim_set_hl(0, 'HarpoonNumberActive', { fg = '#7aa2f7', bold = true })
      vim.api.nvim_set_hl(0, 'HarpoonNumberInactive', { fg = '#7aa2f7' })

      -- Function to get Harpoon window information
      local function get_harpoon_info()
        local list = harpoon:list()
        local current_file_path = vim.fn.expand '%:p'
        local marks = list:display()

        -- Find current file in list
        local current_idx = 0
        for idx, item in ipairs(marks) do
          if item.value == current_file_path then
            current_idx = idx
            break
          end
        end

        return {
          total = #marks,
          current = current_idx,
        }
      end

      -- Set up tabline
      function _G.harpoon_tabline()
        local info = get_harpoon_info()
        if info.current > 0 then
          return string.format('%%#HarpoonActive#  HARPOON %%#HarpoonNumberActive#[%d/%d] ', info.current, info.total)
        else
          return ''
        end
      end

      -- Enable tabline
      vim.opt.showtabline = 2
      vim.opt.tabline = '%!v:lua.harpoon_tabline()'

      -- Create autocommand to refresh tabline
      local augroup = vim.api.nvim_create_augroup('HarpoonTabline', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWrite', 'InsertLeave' }, {
        group = augroup,
        callback = function()
          vim.cmd 'redrawtabline'
        end,
      })

      -- Basic keymaps
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
        vim.cmd 'redrawtabline'
      end, { desc = '[h]arpoon [a]dd current file to list' })

      vim.keymap.set('n', '<leader>ht', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[h]arpoon [t]oggle' })

      vim.keymap.set('n', '<leader>hh', function()
        harpoon:list():prev()
        vim.cmd 'redrawtabline'
      end, { desc = '[h]arpoon previous file' })

      vim.keymap.set('n', '<leader>hl', function()
        harpoon:list():next()
        vim.cmd 'redrawtabline'
      end, { desc = '[h]arpoon next file' })
    end,
  },
}
