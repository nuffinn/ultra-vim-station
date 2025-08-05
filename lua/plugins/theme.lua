-- Theme configuration
local M = {}

function M.setup()
  -- OneDark theme setup
  require('onedark').setup {
    colors = {
      bg0 = '#000000',
      grey = '#616161',
      cyan = '#2de8fc',
      fg = '#ffffff',
      purple = '#ff2e5f',
      blue = '#996eff',
      green = '#a0ff52',
    },
  }
  
  -- Set colorscheme
  vim.cmd [[colorscheme onedark]]
end

return M
