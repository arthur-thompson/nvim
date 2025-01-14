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

{
  "kelly-lin/ranger.nvim",
  config = function()
    require("ranger-nvim").setup({ replace_netrw = true })
    vim.api.nvim_set_keymap("n", "<leader>ef", "", {
      noremap = true,
      callback = function()
        require("ranger-nvim").open(true)
      end,
    })
  end,
},

	"tjdevries/colorbuddy.nvim",
	{ "miikanissi/modus-themes.nvim", priority = 1000 },
{'akinsho/toggleterm.nvim', version = "*", config = true},
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

local ranger_nvim = require("ranger-nvim")
ranger_nvim.setup({
  enable_cmds = false,
  replace_netrw = false,
  keybinds = {
    ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
    ["oh"] = ranger_nvim.OPEN_MODE.split,
    ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
    ["or"] = ranger_nvim.OPEN_MODE.rifle,
  },
  ui = {
    border = "none",
    height = 1,
    width = 1,
    x = 0.5,
    y = 0.5,
  }
})

-- other files

--require("findstuff")

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>',  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>',    { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>',  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Telescope find_files hidden=true<cr>',  { noremap = true })
