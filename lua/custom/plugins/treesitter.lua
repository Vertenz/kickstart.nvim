return {
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
}
