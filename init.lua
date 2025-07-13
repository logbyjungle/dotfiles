require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:' .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {
  },
},
{"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",
config = function()
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
	additional_vim_regex_highlighting = false
      },
      ensure_installed = { "cpp", "c","lua","vim","vimdoc","query","markdown","make","cmake","comment"},
    }
  end
},
{ "catppuccin/nvim", name = "catppuccin", priority = 1000,
  config = function()
    require("catppuccin").setup({
	default_integrations = true,
    })
  end,
},
{ "sphamba/smear-cursor.nvim",
config = function()
    require("smear_cursor").setup({
	stiffness = 0.5,
	damping = 1,
	trailing_stiffness = 0.5,
	matrix_pixel_threshold = 0.5,
	never_draw_over_target = false
    })
end,
},
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
	require("lualine").setup({
	  options = {
	    theme = "catppuccin",
	  },
	})
    end,
},
{
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'default' , ['<Tab>'] = { 'select_and_accept' }},
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
},
{
  'nvimdev/indentmini.nvim',
  config = function()
      require("indentmini").setup() -- use default config
  end,
},
})
vim.cmd.colorscheme("catppuccin")

