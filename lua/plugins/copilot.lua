local M = {}

function M.setup()
  -- Check if copilot is available
  local copilot_ok, copilot = pcall(require, 'copilot')
  if not copilot_ok then
    return
  end

  -- Configure copilot.lua
  copilot.setup({
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<M-CR>"
      },
      layout = {
        position = "bottom",
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = 75,
      keymap = {
        accept = "<C-l>",
        accept_word = "<M-w>",
        accept_line = "<M-j>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      go = true,
      lua = true,
      javascript = true,
      typescript = true,
      python = true,
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = 'node',
    server_opts_overrides = {},
  })

  -- Disable copilot-cmp since we're using built-in suggestions
  -- local copilot_cmp_ok, copilot_cmp = pcall(require, 'copilot_cmp')
  -- if copilot_cmp_ok then
  --   copilot_cmp.setup()
  -- end

  -- Additional keymaps for manual triggering
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Toggle copilot auto-trigger
  keymap('n', '<leader>ct', function()
    require('copilot.suggestion').toggle_auto_trigger()
  end, opts)

  -- Manual trigger in normal mode (enter insert mode and trigger)
  keymap('n', '<leader>cs', function()
    vim.cmd('startinsert')
    vim.defer_fn(function()
      require('copilot.suggestion').next()
    end, 100)
  end, opts)

  -- Force suggestion refresh in insert mode
  keymap('i', '<C-g>', function()
    require('copilot.suggestion').next()
  end, opts)
end

return M
