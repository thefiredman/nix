local cmp = require("blink.cmp")

cmp.setup({
  keymap = {
    preset = 'default',
  },

  -- snippets = { preset = 'luasnip' },

  completion = {
    accept = { auto_brackets = { enabled = true } },
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
    ghost_text = { enabled = false },
  },

  signature = { enabled = true },

  appearance = {
    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
    -- Useful for when your theme doesn't support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = false,
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})
