-- keymapping

vim.g.mapleader = " "

-- install lazy if not already installed

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy setup

require("lazy").setup({
	{"folke/which-key.nvim",
event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }},
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{"nvim-treesitter/nvim-treesitter",
	  build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "bash", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
	  additional_vim_regex_highlighting = false,
        })
    end
 },
	"tjdevries/colorbuddy.nvim",
	{ "miikanissi/modus-themes.nvim", priority = 1000 },
{'akinsho/toggleterm.nvim', version = "*", config = true},
({"lmburns/lf.nvim",
    config = function()
        -- This feature will not work if the plugin is lazy-loaded
        vim.g.lf_netrw = 1

        require("lf").setup({
            escape_quit = false,
            border = "rounded",
        })

        vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")

       -- vim.api.nvim_create_autocmd({
     --       event = "User",
     --       pattern = "LfTermEnter",
      --      callback = function(a)
     --           vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", {nowait = true})
       --     end,
       -- })
    end,
    requires = {"toggleterm.nvim"}
}),
})

-- settings

vim.cmd([[colorscheme modus_vivendi]]) -- modus_operandi, modus_vivendi
termguicolors = true

vim.api.nvim_set_option('mouse', 'a')

vim.opt.undofile = true

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"

-- other files

require("findstuff")
