return {
  'vscode-neovim/vscode-multi-cursor.nvim',
  event = 'VeryLazy',
  cond = not not vim.g.vscode,
  opts = {},
  config = function()
      require('vscode-multi-cursor').setup {
          -- Whether to set default mappings
          default_mappings = true,
          -- If set to true, only multiple cursors will be created without multiple selections
          no_selection = false
      }
  end
}