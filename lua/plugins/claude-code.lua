local M = {}

function M.setup()
  require('claude-code').setup({
    -- Auto-detect and reload files modified by Claude Code
    auto_refresh = true,

    -- Window configuration for Claude Code terminal
    window = {
      position = 'bottom',
      size = 15,
      split = 'horizontal',
    },

    -- Refresh settings
    refresh = {
      -- Check for file changes every 500ms
      interval = 500,
      -- Patterns to watch for changes
      patterns = { '*.lua', '*.go', '*.js', '*.ts', '*.py', '*.md', '*.txt' },
    },
  })
end

return M

