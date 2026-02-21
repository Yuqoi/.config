return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      markdown = { 'prettier' },
      yaml = { 'prettier' }, -- Conform will run multiple formatters sequentially
      -- You can also customize some of the format options for the filetype
      python = { 'ruff_format', 'ruff' },
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      java = { 'google-java-format' },
    },

    -- default_format_opts = {
    --   lsp_format = 'fallback',
    -- },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_on_save = function(bufr)
      local ft = vim.bo[bufr].filetype
      --
      -- if ft == 'java' then
      --   return {
      --     lsp_format = 'fallback',
      --     timeout_ms = 1000,
      --     filter = function(client)
      --       return client.name == 'jdtls'
      --     end,
      --   }
      -- end

      return {
        lsp_format = 'never',
        timeout_ms = 2000,
      }
    end,
    -- I recommend these options. See :help conform.format for details.
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    -- format_after_save = {
    --   lsp_format = 'fallback',
    -- },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
  },
}
