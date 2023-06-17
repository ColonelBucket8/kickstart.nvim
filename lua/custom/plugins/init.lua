-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- TODO: Fix code folding only apply after
-- revisiting the buffer
-- vim.o.foldlevel = 20
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99

return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.handlers['textDocument/publishDiagnostics'] = function(_, result, ctx, ...)
        local client = vim.lsp.get_client_by_id(ctx.client_id)

        if client and client.name == 'eslint' then
          result.diagnostics = vim.tbl_filter(function(diagnostic)
            -- use whatever condition you want to filter diagnostics
            return not diagnostic.message:find 'is assigned a value but never used'
          end, result.diagnostics)
        end

        return vim.lsp.diagnostic.on_publish_diagnostics(nil, result, ctx, ...)
      end
    end,
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
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup {
        transparent = false,
      }

      vim.cmd 'colorscheme tokyonight-storm'
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

      vim.keymap.set('n', '<leader>op', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle Nvim Tree' })
      vim.keymap.set('n', '<leader>oP', '<Cmd>NvimTreeFindFile<CR>')
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.csharpier,
        },

        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      }
    end,
  },
  {
    'tpope/vim-surround',
  },
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<Cmd>LazyGit<CR>', { desc = 'Open LazyGit' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      -- prompt for a refactor to apply when the remap is triggered
      vim.api.nvim_set_keymap(
        'v',
        '<leader>rr',
        ":lua require('refactoring').select_refactor()<CR>",
        { noremap = true, silent = true, expr = false, desc = 'Refactor' }
      )
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
