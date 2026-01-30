return {
  'OXY2DEV/markview.nvim',
  preview = { enable = false },
  ft = { 'markdown' }, -- load only for markdown buffers (recommended)

  opts = {
    preview = {
      enable = false,
      icon_provider = 'mini', -- "internal" | "mini" | "devicons"
    },
  },
  config = function()
    local group = vim.api.nvim_create_augroup('MarkviewMarkdownKeymaps', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'markdown',
      callback = function(ev)
        vim.keymap.set('n', '<leader>mv', '<cmd>Markview toggle<cr>', {
          buffer = ev.buf,
          desc = 'Markview: toggle preview',
          silent = true,
        })

        vim.keymap.set('n', '<leader>ms', '<cmd>Markview splitToggle<cr>', {
          buffer = ev.buf,
          desc = 'Markview: toggle split preview',
          silent = true,
        })
      end,
    })
  end,
}
