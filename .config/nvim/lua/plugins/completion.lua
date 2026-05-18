return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'folke/lazydev.nvim' },
    opts = {
      keymap = {
        preset = 'none',
        ['<C-n>']     = { 'select_next', 'fallback' },
        ['<C-p>']     = { 'select_prev', 'fallback' },
        ['<Tab>']     = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>']   = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>']     = { 'hide', 'fallback' },
        ['<CR>']      = { 'accept', 'fallback' },
        ['<C-u>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>']     = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
      },
      signature = { enabled = false },
    },
    opts_extend = { 'sources.default' },
  },
}
