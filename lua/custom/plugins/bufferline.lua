return {
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
    vim.keymap.set('n', 'tn', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' }),
    vim.keymap.set('n', 'tp', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' }),
    vim.keymap.set('n', 'tc', '<cmd>bd<CR>', { desc = 'Close current' }),
    vim.keymap.set('n', '<leader>tc', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Close other' }),
  },
}
