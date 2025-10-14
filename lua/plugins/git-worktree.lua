-- Git Worktree configuration
local M = {}

function M.setup()
  local status_ok, git_worktree = pcall(require, 'git-worktree')
  if not status_ok then
    return
  end

  -- Setup git-worktree
  git_worktree.setup({
    change_directory_command = 'cd', -- command to change directory
    update_on_change = true, -- update when changing worktrees
    update_on_change_command = 'e .', -- command to run after changing worktree
    clearjumps_on_change = true, -- clear jump list when changing worktrees
    autopush = false, -- auto push changes on worktree switch
  })

  -- Load the Telescope extension
  local telescope_status_ok, telescope = pcall(require, 'telescope')
  if telescope_status_ok then
    telescope.load_extension('git_worktree')
  end

  -- Setup hooks (optional - runs on worktree switch)
  local hooks_ok, Hooks = pcall(require, 'git-worktree.hooks')
  if hooks_ok then
    -- Hook to auto-run PackerSync on worktree switch (optional)
    -- Uncomment if you want to automatically sync plugins when switching worktrees
    -- Hooks.register(Hooks.type.SWITCH, function()
    --   vim.cmd('PackerSync')
    -- end)

    -- Hook to print notification on worktree create/switch
    Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
      vim.notify('Switched to worktree: ' .. path, vim.log.levels.INFO)
    end)

    Hooks.register(Hooks.type.CREATE, function(path, branch)
      vim.notify('Created worktree: ' .. path .. ' for branch: ' .. branch, vim.log.levels.INFO)
    end)
  end
end

-- Custom function to add vertical split support to git worktrees picker
function M.git_worktrees_with_vsplit()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  require('telescope').extensions.git_worktree.git_worktrees({
    attach_mappings = function(_, map)
      -- Add vertical split mapping
      map('i', '<C-v>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsplit')
        require("git-worktree").switch_worktree(selection.path)
      end)

      map('n', '<C-v>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsplit')
        require("git-worktree").switch_worktree(selection.path)
      end)

      return true  -- Keep default mappings (<Enter>, <C-d>, <C-f>)
    end,
  })
end

return M
