return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name  = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
    },
    opts = {
      provider = 'claude',
      auto_suggestions_provider = 'claude',
      providers = {
        claude = {
          endpoint    = 'https://api.anthropic.com',
          model       = 'claude-sonnet-4-5',
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens  = 8096,
          },
        },
      },
      behaviour = {
        auto_suggestions                 = false,
        auto_set_highlight_group         = true,
        auto_set_keymaps                 = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard     = true,
      },
      windows = {
        position = 'right',
        wrap     = true,
        width    = 40,
        sidebar_header = {
          align   = 'center',
          rounded = true,
        },
      },
    },
  },
}
