return {
  -- иконки
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true, -- Плагин будет загружаться только при необходимости
  },
  -- файловое дерево
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        renderer = {
          highlight_opened_files = 'all',
        },
      }
    end,
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' }),
  },
  -- Плагин для управления буферами
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
  },
  -- плагин для управления вкладками
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
}
