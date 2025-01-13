return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        pickers = {
          find_files = {
            previewer = false,
            hidden = true,
          },
          live_grep = {
            layout_config = {
              preview_width = 0,
            }
          },
        },
        defaults = {
          file_ignore_patterns = { 'node_modules' },
          prompt_prefix = '🔍 ',
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--no-ignore',
            '--glob',
            '!.git/',
          },
          mappings = {
            i = {
              -- Mapear a seleção padrão para sair do modo insert
              ['<CR>'] = function(prompt_bufnr)
                actions.select_default(prompt_bufnr)
                vim.cmd 'stopinsert' -- Sai do modo insert
              end,
            },
            n = {
              ['<CR>'] = actions.select_default, -- Normal mode já funciona como esperado
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })

      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope [G]it [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f/', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>ch', '<cmd>Telescope command_history<CR>', { desc = 'Telescope [C]ommand [H]istory' })



      -- vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = '[G]it [S]tatus' })
      -- vim.keymap.set('n', '<leader>gl', '<cmd>Telescope git_commits<CR>', { desc = '[G]it [L]og' })
      -- vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_bcommits<CR>', { desc = '[G]it [C]ommits' })
      -- vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', { desc = '[G]it [B]ranches' })
      vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns preview_hunk_inline<CR>', { desc = '[G]it [D]iff' })


      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>f.', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },
}
