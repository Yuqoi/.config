return {
  'nvim-java/nvim-java',
  dependencies = {
    'mfussenegger/nvim-dap',
    'JavaHello/spring-boot.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('java').setup()
    local home = vim.env.HOME
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    -- local workspace_dir = home .. '\\AppData\\Local\\nvim-data\\jdtls-workspace\\' .. project_name
    local workspace_dir = home .. '/.local/share/nvim/jdtls-workspace/' .. project_name

    vim.lsp.config('jdtls', {
      cmd = {
        '/opt/jdk-21/bin/java',
        -- 'C:\\PROGRA~1\\Java\\jdk-22\\bin\\java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        -- '-javaagent:' .. home .. '\\AppData\\Local\\nvim-data\\nvim-java\\packages\\lombok\\1.18.42\\lombok-1.18.42.jar',
        '-javaagent:'
          .. home
          .. '/.local/share/nvim/mason/share/lombok-nightly/lombok.jar',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        -- Eclipse jdtls location
        '-jar',
        -- home .. '\\AppData\\Local\\nvim-data\\mason\\share\\jdtls\\plugins\\org.eclipse.equinox.launcher.jar',
        home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
        '-configuration',
        -- home .. '\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win',
        home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data',
        workspace_dir,
      },
      root_dir = vim.fs.root(0, { 'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle' }),
      settings = {
        java = {
          -- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
          -- home = 'C:\\PROGRA~1\\Java\\jdk-22',
          home = '/opt/jdk-21',
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = 'interactive',
            -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
            -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
            runtimes = {
              { name = 'JavaSE-22', path = '/opt/jdk-22' },
              { name = 'JavaSE-21', path = '/opt/jdk-21' },
              { name = 'JavaSE-25', path = '/opt/jdk-25' },
            },
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          signatureHelp = { enabled = true },
          format = {
            enabled = true,
            -- Formatting works by default, but you can refer to a specific file/URL if you choose
            -- settings = {
            --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
            --   profile = "GoogleStyle",
            -- },
          },
          completion = {
            favoriteStaticMembers = {
              'org.hamcrest.MatcherAssert.assertThat',
              'org.hamcrest.Matchers.*',
              'org.hamcrest.CoreMatchers.*',
              'org.junit.jupiter.api.Assertions.*',
              'java.util.Objects.requireNonNull',
              'java.util.Objects.requireNonNullElse',
              'org.mockito.Mockito.*',
            },
            importOrder = {
              'java',
              'javax',
              'com',
              'org',
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
          },
        },
      },
    })
    -- vim.keymap.set('n', '<leader>co', function()
    --   vim.lsp.buf.code_action {
    --     context = { only = { 'source.generate' } },
    --     apply = true,
    --   }
    -- end)
    vim.lsp.enable 'jdtls'
  end,
}
