-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      alpha.setup(dashboard.config)

      dashboard.section.header.val = {

        [[                                  __]],
        [[     ██████╗███████╗███████╗    ████████╗███████╗ ██████╗██╗  ██╗]],
        [[    ██╔════╝██╔════╝██╔════╝    ╚══██╔══╝██╔════╝██╔════╝██║  ██║]],
        [[    ██║     ███████╗███████╗       ██║   █████╗  ██║     ███████║]],
        [[    ██║     ╚════██║╚════██║       ██║   ██╔══╝  ██║     ██╔══██║]],
        [[    ╚██████╗███████║███████║       ██║   ███████╗╚██████╗██║  ██║]],
        [[     ╚═════╝╚══════╝╚══════╝       ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝]],
        [[    ███████╗ ██████╗ ██╗     ██╗   ██╗████████╗██╗ ██████╗ ███╗   ██╗███████╗]],
        [[    ██╔════╝██╔═══██╗██║     ██║   ██║╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝]],
        [[    ███████╗██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██╔██╗ ██║███████╗]],
        [[    ╚════██║██║   ██║██║     ██║   ██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║]],
        [[    ███████║╚██████╔╝███████╗╚██████╔╝   ██║   ██║╚██████╔╝██║ ╚████║███████║]],
        [[    ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝    ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝]],
      }

      dashboard.section.buttons.val = {
        dashboard.button('<C-p>', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('<C-n>', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('<leader>fg', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua<CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        toggler = {
          line = '<C-_>', -- Comentar/descomentar linhas com Ctrl + /
          block = '<C-S-_>', -- Comentar/descomentar blocos com Ctrl + Shift + /
        },
        opleader = {
          line = '<C-_>', -- Comentar/descomentar seleção visual com Ctrl + /
          block = '<C-S-_>',
        },
      }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local toggleterm = require 'toggleterm'
      toggleterm.setup {
        size = 20,
        open_mapping = [[<c-j]],
        hide_number = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persister_size = true,
        direction = 'float',
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },
      }
      -- vim.keymap.set({ 'n', 'v', 'c' }, '<C-j>', ':ToggleTerm <CR>')
      -- vim.keymap.set('t', '<C-j>', [[<C-\><C-n>]], { noremap = true, silent = true })
      -- vim.keymap.set('n', '<C-j>', ':ToggleTerm<CR>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v', 'c' }, '<leader>j', ':ToggleTerm <CR>')
      vim.keymap.set('t', '<leader>j', [[<C-\><C-n>]], { noremap = true, silent = true })
    end
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      vim.g.barbar_auto_setup = false

      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

      -- Close buffer
      map('n', '<C-w>', '<Cmd>BufferClose<CR>', opts)
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
      require('flutter-tools').setup {} -- use defaults

    end
    -- config = true,
  },
  {
    'codota/tabnine-nvim',
    build = './dl_binaries.sh',
    config = function()
      local tabnine = require 'tabnine'
      tabnine.setup {
        disable_auto_comment = true,
        accept_keymap = '<Tab>',
        dismiss_keymap = 'Esc',
        debounce_ms = 800,
        suggestion_color = { gui = '#808080', cterm = 244 },
        exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
        log_file_path = nil, -- absolute path to Tabnine log file
        ignore_certificate_errors = false,
      }
    end,
  },
  {
    'nvim-java/nvim-java',
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- {
  --   'navarasu/onedark.nvim',
  --   config = function()
  --    require('onedark').setup({
  --       style = 'darker'
  --     })
  --     require('onedark').load()
  --   end
  -- },
  {
    'ThePrimeagen/vim-be-good',
    cmd = { 'VimBeGood' },
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        vim.keymap.set('n', '<Leader>ls', require('auto-session.session-lens').search_session, {
          noremap = true,
        }),
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  }
}
