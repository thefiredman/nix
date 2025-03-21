require("nvim-treesitter.configs").setup({
  ignore_install = {},
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

require('nvim-ts-autotag').setup({})
