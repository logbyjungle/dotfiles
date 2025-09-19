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
    "smolck/command-completion.nvim",
    config = function()
        require('command-completion').setup({
            border = nil,
            max_col_num = 5,
            min_col_width = 20,
            use_matchfuzzy = true,
            highlight_selection = true,
            highlight_directories = true,
            tab_completion = true,
        })
	end,
},
{ "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function()
    require("catppuccin").setup({
	    default_integrations = true,
    })
  end,
},
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
    require("nvim-treesitter.configs").setup {
          ensure_installed = { "python", "lua", "bash", "json", "cpp" ,"c","vim","vimdoc","query","markdown","make","cmake","comment"},
          highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
          },
    }
    end
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
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
            ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
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
},
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {}
},
{
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
},
{
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
         require("telescope").load_extension("smart_open")
    end,
    dependencies = {
    "kkharji/sqlite.lua",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-fzy-native.nvim" },
    { "nvim-telescope/telescope.nvim"},
    },
},
{
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
    {
        "<A-e>",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
    },
    },
    opts = {
    open_for_directories = false,
    keymaps = {
        show_help = "<f1>",
        },
    },
    init = function()
    vim.g.loaded_netrwPlugin = 1
    end,
},
-- {
    -- "smjonas/live-command.nvim",
    -- config = function()
        -- require("live-command").setup()
    -- end,
-- },
{
    "dundalek/lazy-lsp.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
        require("lazy-lsp").setup {
            servers = {
                "bashls",
                "clangd",
            },
            excluded_servers = {
                "glsls",
                "ltex"
            },
            prefer_local = true,
            preferred_servers = {
                glsl = {
                    "glsl_analyzer",
                },
                lua = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {"vim"},
                            },
                        },
                    },
                },
                python = {
                    "pyright",
                    settings = {
                        python = {
                            analyst = {
                                typeCheckingMode = "basic",
                                reportMissingImports = true,
                                diagnosticMode = "workspace"
                            }
                        }
                    }
               }
            }
        }
    end
},
{
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
},
{
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
        require('render-markdown').setup({
            html = {
                enabled = false
            },
            latex = {
                enabled = false
            },
            yaml = {
                enabled = false
            }
        })
    end
},
{
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()
    end
},
{
    "linux-cultist/venv-selector.nvim",
    dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    keys = {
    { ",v", "<cmd>VenvSelect<cr>" },
    },
    ---@type venv-selector.Config
    opts = {
    -- Your settings go here
    },
},
{
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'qwertyuiopasdfghjklzxcvbnm'
    }
},
})
vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= nil and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(arg))
            vim.cmd("argdelete *")
            vim.cmd("enew")
            vim.cmd("Yazi")
        end
    end,
})

vim.diagnostic.config({
    virtual_text = true
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end
})
