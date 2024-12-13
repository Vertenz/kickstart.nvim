-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true, -- Плагин будет загружаться только при необходимости
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*', -- Убедитесь, что установлена последняя версия
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Для иконок
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- Показывает буферы
          separator_style = 'slant', -- Красивый стиль разделителей
          diagnostics = 'nvim_lsp', -- Показывает диагностику LSP
          show_buffer_icons = true, -- Иконки
          show_buffer_close_icons = true,
          show_close_icon = false,
          always_show_bufferline = true,
        },
      }
    end,
    vim.keymap.set('n', 'tn', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' }),
    vim.keymap.set('n', 'tp', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' }),
    vim.keymap.set('n', 'tc', '<cmd>bd<CR>', { desc = 'Close current' }),
    vim.keymap.set('n', '<leader>tc', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Close other' }),
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- Убедитесь, что Treesitter установлен
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Включить плагин
        multiwindow = false, -- Поддержка нескольких окон
        max_lines = 0, -- Без ограничения на количество строк
        min_window_height = 0, -- Минимальная высота окна редактора для активации
        line_numbers = true, -- Показывать номера строк в контексте
        multiline_threshold = 20, -- Максимальное количество строк для одного контекста
        trim_scope = 'outer', -- Какие строки обрезать, если превышен `max_lines`
        mode = 'cursor', -- Использовать строку курсора для расчёта контекста
        separator = nil, -- Нет разделителя
        zindex = 20, -- Z-index окна
        on_attach = nil, -- Опциональная функция для управления прикреплением
      }
    end,
  },
  -- сохраняет версии файлов
  {
    'mbbill/undotree',
    vim.keymap.set('n', '<C-U>', vim.cmd.UndotreeToggle, { noremap = true, silent = true }),
  },
  {
    'github/copilot.vim',
  },
  -- автозакрывание тега
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  -- множетсво терминалов
  {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<C-\>]],
        hide_numbers = false,
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = 'zsh',
      }
    end,
  },
  -- множетсвенный курсор
  {
    'mg979/vim-visual-multi',
    config = function()
      vim.g.VM_maps = 0
    end,
  },
  -- popups
  {
    'voldikss/vim-floaterm',
  },
  {
    'nvim-lua/plenary.nvim',
  },
  -- git
  {
    'kdheepak/lazygit.nvim',
    lazy = false,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').load_extension 'lazygit'
    end,
  },
}
