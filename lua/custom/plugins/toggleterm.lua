return {
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
}
