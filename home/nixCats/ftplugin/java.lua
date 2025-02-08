vim.api.nvim_command("packadd nvim-jdtls")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

local config = {
  cmd = { 'jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  on_attach = function(_, bufnr)
    require "usr.lsps".on_attach(_, bufnr)
  end
}

require('jdtls').start_or_attach(config)
