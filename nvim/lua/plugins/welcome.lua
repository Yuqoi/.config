return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[ ___  _ _     ____  ____  _  ]],
      [[ \  \/// \ /\/  _ \/  _ \/ \ ]],
      [[  \  / | | ||| / \|| / \|| | ]],
      [[  / /  | \_/|| \_\|| \_/|| | ]],
      [[ /_/   \____/\____\\____/\_/ ]],
    }

    alpha.setup(dashboard.opts)
  end,
}
