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
          ensure_installed = { "python", "lua", "bash", "json", "cpp" ,"c","vim","vimdoc","query","markdown","make","cmake","comment","dockerfile"},
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
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },
        completion = { 
            documentation = { 
                auto_show = false,
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                }
            }
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = {
            ['<Tab>'] = {'accept','fallback'}
        }
    },
    opts_extend = { "sources.default" }
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
                "dockerls"
            },
            excluded_servers = {
                "glsls",
                "ltex"
            },
            prefer_local = true,
            preferred_servers = {
                docker = {
                    "dockerls",
                    settings = {
                        docker = {
                            languageserver = {
                                formatter = {
                                    ignoreMultilineInstructions = true,
                                },
                            }
                        }
                    }
                },
                glsl = {
                    "glsl_analyzer",
                },
                lua = {
                    -- "lua_ls",
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
        require("gitsigns").setup({
            current_line_blame = false
        })
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
        warn_when_search_is_slow = false
    },
},
{
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'qwertyuiopasdfghjklzxcvbnm'
    }
},
-- {
    -- 'akinsho/bufferline.nvim',
    -- version = "*",
    -- dependencies = 'nvim-tree/nvim-web-devicons',
    -- config = function()
        -- require("bufferline").setup({})
    -- end
-- },
{
    'Yinameah/nvim-tabline',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional
    opts = {
        show_index = true
    }
},
{
    "okuuva/auto-save.nvim",
    version = '*',
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
    -- your config goes here
    -- or just leave it empty :)
    },
},
{
    'voldikss/vim-floaterm'
},
{
  "swaits/universal-clipboard.nvim",
  opts = {
    verbose = false, -- optional: set true to log detection details
  },
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
