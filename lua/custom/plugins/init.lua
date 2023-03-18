-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<leader>op', "<Cmd>NvimTreeToggle<CR>")
vim.keymap.set('n', '<leader>oP', "<Cmd>NvimTreeFindFile<CR>")

return {
  {
    'Mofiqul/vscode.nvim',
    config = function()
      require('vscode').load('dark')
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup(
        {
          view = {
            side = "right"
          }
        }
      )
    end
  },
}
