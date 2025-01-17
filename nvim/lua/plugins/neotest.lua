return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    config = function()
      local neotest = require 'neotest'

      local function handle_test_results(test_results)
        local errors = {}
        for position_id, result in pairs(test_results) do
          local pos = neotest.positions.get(position_id)
          if result.status == 'failed' then
            table.insert(errors, {
              filename = pos.path,
              lnum = pos.range[1] + 1, -- Convert to 1-based line number
              text = result.short .. (result.errors and result.errors[1] or ''),
              type = 'E',
            })
          end
        end

        if #errors > 0 then
          vim.fn.setqflist(errors)
          vim.cmd 'copen'
        else
          vim.fn.setqflist {}
          vim.cmd 'cclose'
        end
      end

      neotest.setup {
        adapters = {
          require 'neotest-python' {
            runner = 'pytest',
            python = vim.fn.exepath 'python3',
            args = { '--verbose' },
            root_files = { 'pyproject.toml', 'setup.cfg', 'setup.py', 'pytest.ini' },
          },
        },
        output = {
          open_on_run = true,
          enter = true,
        },
        status = {
          virtual_text = true,
          signs = true,
        },
      }

      -- vim.api.nvim_create_autocmd('BufWritePost', {
      --   pattern = '*.py',
      --   callback = function()
      --     neotest.run.run(vim.fn.expand '%', {
      --       handler = handle_test_results,
      --     })
      --   end,
      -- })
      --
      vim.keymap.set('n', '<leader>tt', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = 'Run current file' })

      vim.keymap.set('n', '<leader>ts', function()
        neotest.summary.toggle()
      end, { desc = 'Toggle test summary' })

      vim.keymap.set('n', '<leader>to', function()
        neotest.output.open { enter = true }
      end, { desc = 'Show test output' })
    end,
    ft = { 'python' },
    keys = {
      { '<leader>tt', desc = 'Run current file' },
      { '<leader>ts', desc = 'Toggle test summary' },
      { '<leader>to', desc = 'Show test output' },
    },
  },
}
