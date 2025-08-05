-- Keymapping configuration
local M = {}

function M.setup()
  -- Basic keymaps
  vim.keymap.set("n", "<leader>w", ":write<CR>", { silent = true, desc = "Save file" })
  
  -- Remap for dealing with word wrap
  vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  
  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Set diagnostic loclist" })
  
  -- Go formatting
  vim.api.nvim_set_keymap('n', '<leader>fm', ':GoFmt<CR>', { noremap = true, silent = true, desc = "Format Go file" })
  -- NERDTree
  vim.api.nvim_set_keymap('n', '<leader>tf', ':NERDTreeFind<CR>', { noremap = true, silent = true, desc = "Find in NERDTree" })
  -- Custom function (needs to be defined elsewhere)
  vim.api.nvim_set_keymap('n', '<leader>ff', ':lua JumpToPreviousFunc()<CR>', { noremap = true, silent = true, desc = "Jump to previous function" })
  
  -- LSP debug keybindings
  vim.keymap.set('n', '<leader>li', ':LspInfo<CR>', { desc = 'LSP Info' })
  vim.keymap.set('n', '<leader>lr', ':LspRestart<CR>', { desc = 'LSP Restart' })
end

return M
