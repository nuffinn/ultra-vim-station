-- Treesitter configuration
local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
    -- Languages to install
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'dart', 'vim' },

    highlight = { enable = true },
    indent = { enable = true, disable = { 'python' } },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-backspace>',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']]'] = '@function.outer',
          [']m'] = '@class.outer',
        },
        goto_next_end = {
          [']['] = '@function.outer',
          [']M'] = '@class.outer',
        },
        goto_previous_start = {
          ['[['] = '@function.outer',
          ['[m'] = '@class.outer',
        },
        goto_previous_end = {
          ['[]'] = '@function.outer',
          ['[M'] = '@class.outer',
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>pa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>pA'] = '@parameter.inner',
        },
      },
    },
  }
end

return M
