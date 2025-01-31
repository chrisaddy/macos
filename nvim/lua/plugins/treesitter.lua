return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'regex',
      'rust',
      'query',
      'sql',
      'terraform',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    textobjects = {
      select = {
        enable = false,
      },
      move = {
        enable = true,
      },
    },
  },
}
