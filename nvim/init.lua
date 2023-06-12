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

local use = require("packer").use
require("packer").startup(function()

  use ("wbthomason/packer.nvim")

  use ("nvim-lua/popup.nvim")

  use ({
  "nvim-telescope/telescope.nvim",
  requires = { {"nvim-lua/plenary.nvim"} }
})

    use ({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
        })

use {
  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup {
      -- your configuration comes here
    }
  end
}

end)

if os.getenv("INSTALL") then
	goto eof
end

vim.api.nvim_set_option('mouse', 'a')

vim.opt.undofile = true

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"

require("findstuff")

vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

::eof::
