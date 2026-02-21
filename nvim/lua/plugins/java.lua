return {
  'nvim-java/nvim-java',
  dependencies = {
    'mfussenegger/nvim-dap',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('java').setup {
      java_test = { enable = true },
      java_debug_adapter = { enable = true },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'jdtls' then
          require('spring_boot').init_lsp_commands()
        end
      end,
    })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        vim.keymap.set('n', '<leader>Jr', '<cmd>JavaRunnerRunMain<CR>', {
          desc = 'Run main',
          buffer = true,
        })
        vim.keymap.set('n', '<leader>Jt', '<cmd>JavaTestRunCurrentClass<CR>', {
          desc = 'Run test inside class',
          buffer = true,
        })
        vim.keymap.set('n', '<leader>Jl', '<cmd>JavaTestViewLastReport<CR>', {
          desc = 'Run log of tests',
          buffer = true,
        })
      end,
    })
    vim.lsp.enable 'jdtls'
  end,
}

-- SAVING FOR FUTURE BECAUSE ADDING THIS JAVA LSP SUCKS
-- vim.lsp.config('jdtls', {
--   cmd = {
--     '/opt/jdk-21/bin/java',
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-javaagent:' .. home .. '/.local/share/nvim/mason/share/lombok-nightly/lombok.jar',
--     '-Xmx4g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens',
--     'java.base/java.util=ALL-UNNAMED',
--     '--add-opens',
--     'java.base/java.lang=ALL-UNNAMED',
--
--     -- Eclipse jdtls location
--     '-jar',
--     home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
--     '-configuration',
--     home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
--     '-data',
--     workspace_dir,
--   },
--
--   root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle' }),
--
--   settings = {
--     java = {
--       home = '/opt/jdk-21',
--
--       eclipse = { downloadSources = true },
--       configuration = {
--         updateBuildConfiguration = 'interactive',
--         runtimes = {
--           { name = 'JavaSE-22', path = '/opt/jdk-22' },
--           { name = 'JavaSE-21', path = '/opt/jdk-21' },
--           { name = 'JavaSE-25', path = '/opt/jdk-25' },
--         },
--       },
--       maven = { downloadSources = true },
--       implementationsCodeLens = { enabled = true },
--       referencesCodeLens = { enabled = true },
--       references = { includeDecompiledSources = true },
--       signatureHelp = { enabled = true },
--       format = {
--         enabled = true,
--         settings = {
--           url = 'https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml',
--           profile = 'GoogleStyle',
--         },
--       },
--       contentProvider = { preffered = 'fernflower' }, -- (typo kept as in your config)
--       completion = {
--         chain = { enabled = true },
--         favoriteStaticMembers = {
--           'org.hamcrest.MatcherAssert.assertThat',
--           'org.hamcrest.Matchers.*',
--           'org.hamcrest.CoreMatchers.*',
--           'org.junit.jupiter.api.Assertions.*',
--           'java.util.Objects.requireNonNull',
--           'java.util.Objects.requireNonNullElse',
--           'org.mockito.Mockito.*',
--           'org.springframework.test.web.servlet.request.',
--         },
--         maxResults = 0,
--         guessMethodArguments = true,
--         postfix = { enabled = true },
--       },
--       sources = {
--         organizeImports = {
--           starThreshold = 9999,
--           staticStarThreshold = 9999,
--         },
--       },
--       codeGeneration = {
--         toString = {
--           template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
--         },
--         hashCodeEquals = { useJava7Objects = true },
--         useBlocks = true,
--       },
--     },
--   },
-- })
