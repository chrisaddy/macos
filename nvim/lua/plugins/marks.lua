return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { '<leader>tm', '<cmd>Telescope marks<cr>', desc = '[s]earch [m]arks' },
  },
  config = function()
    vim.keymap.set('n', '<leader>sm', '<cmd>Telescope marks<cr>', { desc = '[s]earch [m]arks' })

    local function list_marks()
      local marks_list = vim.fn.getmarklist(vim.fn.bufnr())
      local results = {}
      for _, mark in ipairs(marks_list) do
        if mark.mark:match '^[a-zA-Z]$' then
          table.insert(results, mark.file .. ':' .. mark.pos[2])
        end
      end
      return results
    end

    function _G.jump_to_mark()
      local line = vim.api.nvim_get_current_line()
      local file, lineno = string.match(line, '(.-):(%d+)')
      if file and lineno then
        vim.cmd('e ' .. file)
        vim.cmd(':' .. lineno)
        vim.api.nvim_win_close(0, true)
      end
    end

    function _G.delete_mark()
      local line = vim.api.nvim_get_current_line()
      local file, lineno = string.match(line, '(.-):(%d+)')
      if file and lineno then
        -- Remove the mark from the buffer
        local marks_list = vim.fn.getmarklist(vim.fn.bufnr())
        for _, mark in ipairs(marks_list) do
          if mark.file == file and mark.pos[2] == tonumber(lineno) then
            vim.fn.setpos("'" .. mark.mark, { 0, 0, 0, 0 }) -- Set mark position to invalid to delete
            break
          end
        end
        vim.api.nvim_buf_set_lines(0, vim.fn.line '.' - 1, vim.fn.line '.', false, {})
      end
    end

    function _G.open_marks_menu()
      local lines = list_marks()
      if #lines == 0 then
        print 'No bookmarks set.'
        return
      end

      local buf = vim.api.nvim_create_buf(false, true)
      local width = math.floor(vim.o.columns * 0.5)
      local height = math.floor(vim.o.lines * 0.5)
      local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = (vim.o.lines - height) / 2,
        col = (vim.o.columns - width) / 2,
        style = 'minimal',
        border = 'rounded',
      }
      vim.api.nvim_open_win(buf, true, opts)

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua jump_to_mark()<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, 'n', 'd', ':lua delete_mark()<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':lua vim.api.nvim_win_close(0, true)<CR>', { noremap = true, silent = true })
    end

    vim.api.nvim_set_keymap('n', '<leader>bo', ':lua open_marks_menu()<CR>', { noremap = true, silent = true })
  end,
}
