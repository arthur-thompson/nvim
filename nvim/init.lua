local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
	false
)

-- local async = require "plenary.async"

vim.api.nvim_set_option('number', true)

local use = require("packer").use
require('packer').startup(function()

  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'

  use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
        }

end)

if os.getenv("INSTALL") then
	goto eof
end

vim.opt.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

require("findstuff")

vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

::eof::
