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
            local message_to_filter = {
              'is assigned a value but never used',
              'is defined but never used',
            }

            for _, message in ipairs(message_to_filter) do
              if diagnostic.message:find(message) then
                return false
              end
            end
            return true
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
    keys = {
      { '<leader>op', '<Cmd>NvimTreeToggle<CR>',   desc = 'Toggle Nvim Tree' },
      { '<leader>oP', '<Cmd>NvimTreeFindFile<CR>', desc = 'Reveal file in Nvim Tree' },
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
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.code_actions.gitsigns,
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
    keys = {
      { '<leader>gg', '<Cmd>LazyGit<CR>', desc = 'Open LazyGit' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {

    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        config = {
          header = {
            '             ▄▄▀▀▀▀▀▀▀▀▄▄              ',
            '          ▄▀▀            ▀▄▄           ',
            '        ▄▀                  ▀▄         ',
            '       ▌             ▀▄       ▀▀▄      ',
            '      ▌                ▀▌        ▌     ',
            '     ▐                  ▌        ▐     ',
            '     ▌▐    ▐    ▐       ▌         ▌    ',
            '    ▐ ▌    ▌  ▐ ▌      ▐       ▌▐ ▐    ',
            '    ▐ ▌    ▌▄▄▀▀▌▌     ▐▀▌▀▌▄  ▐ ▌ ▌   ',
            '     ▌▌    ▐▀▄▌▌▐▐    ▐▐▐ ▐ ▌▌ ▐ ▌▄▐   ',
            '   ▄▀▄▐    ▌▌▄▀▄▐ ▌▌ ▐ ▌▄▀▄ ▐  ▐ ▌ ▀▄  ',
            '  ▀▄▀  ▌  ▄▀ ▌█▐  ▐▐▀   ▌█▐ ▀▄▐ ▌▌   ▀ ',
            '   ▀▀▄▄▐ ▀▄▀ ▀▄▀        ▀▄▀▄▀ ▌ ▐      ',
            '      ▀▐▀▄ ▀▄        ▐      ▀▌▐        ',
            '        ▌ ▌▐ ▀              ▐ ▐        ',
            '        ▐ ▐ ▌    ▄▄▀▀▀▀▄    ▌ ▐        ',
            '         ▌▐ ▐▄   ▐     ▌  ▄▀  ▐        ',
            '        ▐  ▌▐▐▀▄  ▀▄▄▄▀ ▄▀▐   ▐        ',
            '        ▌▌ ▌▐ ▌ ▀▄▄    ▄▌▐ ▌  ▐        ',
            '       ▐ ▐ ▐▐ ▌    ▀▀▄▀▌▐  ▌  ▌        ',
            '       ▌  ▌▐ ▌        ▐▀▄▌ ▐           ',
            '',
          },
        },
      }
    end,
    requires = { 'nvim-tree/nvim-web-devicons' },
  },
}
