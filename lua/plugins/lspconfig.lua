return {
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "j-hui/fidget.nvim",
        opts = {
          -- options
        },
      }
    },
    config = function()
      -- slow lsp on 0.10 https://github.com/neovim/neovim/issues/23725
      -- keep watch of https://github.com/neovim/neovim/issues/23291
      if false then
        local ok, wf = pcall(require, "vim.lsp._watchfiles")
        if ok then
          -- disable lsp watcher. Too slow on linux
          wf._watchfunc = function()
            return function() end
          end
        end
      end

      require("mason").setup()
      require("mason-lspconfig").setup()

      -- local navbuddy = require("nvim-navbuddy")
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- navbuddy.attach(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

        -- vim.keymap.set('n', '<space>n', require("nvim-navbuddy").open, bufopts)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local lsp_flags = {
        -- This is the default in Nvim 0.7+
        debounce_text_changes = 150,
      }


      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,

        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = {
              enable = false,
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }

      local util = require 'lspconfig.util'
      local function get_typescript_server_path(root_dir)
        local global_ts = vim.fn.expand('$HOME') .. '/.npm/lib/node_modules/typescript/lib'

        local found_ts = ''
        local function check_dir(path)
          found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
          if util.path.exists(found_ts) then
            return path
          end
        end

        if util.search_ancestors(root_dir, check_dir) then
          return found_ts
        else
          return global_ts
        end
      end

      --lspconfig.tsserver.setup {
      --  on_attach = on_attach,
      --  flags = lsp_flags,
      --}
      lspconfig.volar.setup {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        -- log_level = vim.lsp.protocol.MessageType.Log,
        -- cmd = { "./node_modules/.bin/vue-language-server", "--stdio" },
        on_new_config = function(new_config, new_root_dir)
          local project_dir = util.find_node_modules_ancestor(new_root_dir)
          if project_dir then
            local bin = util.path.join(project_dir, 'node_modules', '.bin', 'vue-language-server')
            if util.path.exists(bin) then
              print("setting project specific vue-language-server path")
              new_config.cmd = { bin, '--stdio' }
            end
          end
          new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
        end,
      }
      -- lspconfig.solargraph.setup {
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      --   cmd = { "bundle", "exec", "solargraph", "stdio" }
      -- }
      lspconfig.ruby_ls.setup {
        on_attach = on_attach,
        flags = lsp_flags,
        init_options = {
          formatter = 'auto',
          experimentalFeaturesEnabled = true
        },
      }
      lspconfig.stimulus_ls.setup {
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { "html", "ruby", "eruby", "blade", "php", "slim" }
      }
      lspconfig.graphql.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
      }
      --lspconfig.grammarly.setup {
      --  on_attach = on_attach,
      --  flags = lsp_flags,
      --  settings = {
      --    grammarly = {
      --      config = {
      --        documentDialect = "british",
      --        documentDomain = "mail"
      --      },
      --      userWords = {
      --        "brifter",
      --        "brifters"
      --      }
      --    }
      --  }
      --}
      --
      lspconfig.terraformls.setup {
        on_attach = on_attach,
        flags = lsp_flags,
      }
      lspconfig.tailwindcss.setup {
        on_attach = on_attach,
        flags = lsp_flags,
        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
          "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex",
          "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css",
          "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript",
          "typescript", "typescriptreact", "vue", "svelte", "ruby" },
        init_options = {
          userLanguages = {
            ruby = "php",
          },
        },
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                [[class= "([^"]*)]],
                [[class: "([^"]*)]],
                [[class= '([^']*)]],
                [[class: '([^']*)]],
                '~H""".*class="([^"]*)".*"""',
                '~F""".*class="([^"]*)".*"""',
              },
            }
          }
        }
      }
      lspconfig.grammarly.setup {
        on_attach = on_attach,
        flags = lsp_flags,
        settings = {
          grammarly = {
            config = {
              documentDialect = "british",
              documentDomain = "mail"
            },
            userWords = {
              "brifter",
              "brifters"
            }
          }
        }
      }
      lspconfig.ansiblels.setup {
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        settings = {
          ansible = {
            ansible = {
              path = "ansible",
            },
          },
        },
      }

      -- lspconfig["css-lsp"].setup{
      --   on_attach = on_attach,
      --   flags = lsp_flags,
      -- }
      --
    end
  }
}
