-- Auto commands and highlights
local M = {}

function M.setup()
  -- Highlight on yank
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
  })
  
  -- Custom highlights
  vim.cmd [[
    highlight CustomFileName guifg=#abcdef guibg=#590055 gui=bold
    highlight CustomGpsOutput guifg=#00186e guibg=#e36fa1 gui=italic
  ]]
  
  -- Auto-enable git blame in git repositories
  local gitblame_group = vim.api.nvim_create_augroup('GitBlameAuto', { clear = true })
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      local git_dir = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')
      if git_dir ~= '' then
        vim.cmd('GitBlameEnable')
      end
    end,
    group = gitblame_group,
    pattern = '*',
  })
  
  -- Packer auto-reload
  local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
  })
end

return M
