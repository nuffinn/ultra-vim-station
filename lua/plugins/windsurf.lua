local M = {}

function M.setup()
  -- Check if codeium is available
  local codeium_ok, codeium = pcall(require, 'codeium')
  if not codeium_ok then
    return
  end

  -- Configure codeium (windsurf)
  codeium.setup({
    enable_chat = true,
    -- Keep same keybind behavior as copilot
    virtual_text = {
      enabled = true,
      manual = false,
      idle_delay = 75,
      virtual_text_priority = 65535,
      map_keys = true,
      accept_fallback = nil,
      key_bindings = {
        accept = "<M-l>",        -- Same as copilot accept
        accept_word = "<M-w>",   -- Same as copilot accept_word
        accept_line = "<M-j>",   -- Same as copilot accept_line
        next = "<M-]>",          -- Same as copilot next
        prev = "<M-[>",          -- Same as copilot prev
        clear = "<C-]>",         -- Same as copilot dismiss
      }
    }
  })

  -- Additional keymaps for manual triggering (keeping same binds as copilot)
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Toggle codeium auto-trigger (same as copilot)
  keymap('n', '<leader>ct', '<cmd>Codeium Toggle<cr>', opts)

  -- Manual trigger in normal mode (enter insert mode and trigger)
  keymap('n', '<leader>cs', function()
    vim.cmd('startinsert')
    vim.defer_fn(function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<M-]>', true, false, true))
    end, 100)
  end, opts)

  -- Force suggestion refresh in insert mode
  keymap('i', '<C-g>', function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<M-]>', true, false, true))
  end, opts)

  -- Additional codeium commands
  keymap('n', '<leader>cc', '<cmd>Codeium Chat<cr>', { desc = 'Open Codeium Chat' })
end

return M