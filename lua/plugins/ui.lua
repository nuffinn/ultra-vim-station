-- UI and statusline configuration
local M = {}

function M.setup()
  -- Setup nvim-gps
  require('nvim-gps').setup {
    disable_icons = true,
  }
  
  -- Setup lualine with gps integration
  local gps = require 'nvim-gps'
  
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          color = 'CustomFileName',
        },
        {
          gps.get_location,
          cond = gps.is_available,
          color = 'CustomGpsOutput',
        },
      },
    },
  }
  
  -- Setup gitsigns
  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  }
  
  -- Setup DAP UI
  require('dapui').setup()
  
  -- Setup git blame
  require('gitblame').setup {
    enabled = false,
  }
end

return M
