-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>op', '<Cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>oP', '<Cmd>NvimTreeFindFile<CR>')

return {
  {
    'Mofiqul/vscode.nvim',
    -- config = function()
    --   require('vscode').load('dark')
    -- end
  },
  {
    'shaunsingh/nord.nvim',
    -- config = function()
    --   vim.cmd([[
    --     colorscheme nord
    --   ]])
    -- end
  },
  {
    'tanvirtin/monokai.nvim',
    config = function()
      require('monokai').setup {}
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        -- view = {
        --   side = "right"
        -- }
      }
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
        },
      }
    end,
  },

  -- {
  --   'glepnir/dashboard-nvim',
  --   config = function()
  --     local home = os.getenv('UserProfile')
  --     local db = require('dashboard').setup({
  --       preview_command = 'cat',
  --       -- linux
  --       -- db.preview_command = 'ueberzug'
  --
  --
  --       header = {
  --         "             ▄▄▀▀▀▀▀▀▀▀▄▄              ",
  --         "          ▄▀▀            ▀▄▄           ",
  --         "        ▄▀                  ▀▄         ",
  --         "       ▌             ▀▄       ▀▀▄      ",
  --         "      ▌                ▀▌        ▌     ",
  --         "     ▐                  ▌        ▐     ",
  --         "     ▌▐    ▐    ▐       ▌         ▌    ",
  --         "    ▐ ▌    ▌  ▐ ▌      ▐       ▌▐ ▐    ",
  --         "    ▐ ▌    ▌▄▄▀▀▌▌     ▐▀▌▀▌▄  ▐ ▌ ▌   ",
  --         "     ▌▌    ▐▀▄▌▌▐▐    ▐▐▐ ▐ ▌▌ ▐ ▌▄▐   ",
  --         "   ▄▀▄▐    ▌▌▄▀▄▐ ▌▌ ▐ ▌▄▀▄ ▐  ▐ ▌ ▀▄  ",
  --         "  ▀▄▀  ▌  ▄▀ ▌█▐  ▐▐▀   ▌█▐ ▀▄▐ ▌▌   ▀ ",
  --         "   ▀▀▄▄▐ ▀▄▀ ▀▄▀        ▀▄▀▄▀ ▌ ▐      ",
  --         "      ▀▐▀▄ ▀▄        ▐      ▀▌▐        ",
  --         "        ▌ ▌▐ ▀              ▐ ▐        ",
  --         "        ▐ ▐ ▌    ▄▄▀▀▀▀▄    ▌ ▐        ",
  --         "         ▌▐ ▐▄   ▐     ▌  ▄▀  ▐        ",
  --         "        ▐  ▌▐▐▀▄  ▀▄▄▄▀ ▄▀▐   ▐        ",
  --         "        ▌▌ ▌▐ ▌ ▀▄▄    ▄▌▐ ▌  ▐        ",
  --         "       ▐ ▐ ▐▐ ▌    ▀▀▄▀▌▐  ▌  ▌        ",
  --         "       ▌  ▌▐ ▌        ▐▀▄▌ ▐           ",
  --       },
  --       preview_file_path = home .. '\\AppData\\Local\\nvim\\lua\\config\\dashboard.cat',
  --       preview_file_height = 20,
  --       preview_file_width = 50,
  --       custom_center = {
  --         {
  --           icon = '  ',
  --           desc = 'Recently latest session                 ',
  --           shortcut = '       ',
  --           action = 'SessionLoad'
  --         },
  --         {
  --           icon = '  ',
  --           desc = 'Recently opened files                   ',
  --           action = 'browse oldfiles',
  --           shortcut = '       '
  --         },
  --         {
  --           icon = '  ',
  --           desc = 'Find File                               ',
  --           action = 'Files',
  --           shortcut = 'SPC p f'
  --         },
  --         {
  --           icon = '  ',
  --           desc = 'File Browser                            ',
  --           action = 'NvimTreeToggle',
  --           shortcut = 'SPC o p'
  --         },
  --         {
  --           icon = '  ',
  --           desc = 'Find word                                ',
  --           action = 'Rg',
  --           shortcut = 'SPC p g'
  --         },
  --       }
  --     })
  --   end
  -- }
}
