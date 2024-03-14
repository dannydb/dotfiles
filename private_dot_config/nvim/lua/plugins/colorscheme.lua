return {
  -- add gruvbox
  { "lunarvim/synthwave84.nvim", },
  -- {
  --     'maxmx03/fluoromachine.nvim',
  --     config = function ()
  --       local fm = require 'fluoromachine'

  --       fm.setup {
  --         glow = true,
  --         theme = 'delta'
  --       }

  --       vim.cmd.colorscheme 'fluoromachine'
  --     end
  -- },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    cond = not vim.g.vscode,
    opts = {
      colorscheme = "synthwave84",
    },
  }
}