return {
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'npm install',
    config = function()
      require 'custom.settings.coc'
    end,
  },
}
