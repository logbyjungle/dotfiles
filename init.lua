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
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    opts = function()
        local cmp = require("cmp")
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local auto_select = true
        return {
        completion = {
            completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = auto_select }),
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
            ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
            end,
            ["<C-CR>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                fallback()
            end
        end,
        }),
        sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        }, {
        { name = "buffer" },
        }),
        formatting = {
            format = function(entry, item)
            return item
            end,
        },
        experimental = {
            ghost_text = false,
        },
    }
    end,
},
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
}
})
vim.cmd.colorscheme("catppuccin")

