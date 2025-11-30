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
        appearance = {
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
---@type LazySpec
{
    "mikavilpas/yazi.nvim",
    version = "*",
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
    ---@type YaziConfig | {}
    opts = {
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
        },
        change_neovim_cwd_on_close = true,
        floating_window_scaling_factor = 0.85,
        future_features = {
          use_cwd_file = true,
          new_shell_escaping = true,
        },
    },
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
},
{
    "smjonas/live-command.nvim",
    config = function()
        require("live-command").setup()
    end,
},
{
    "dundalek/lazy-lsp.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
        require("lazy-lsp").setup {
            use_vim_lsp_config = true,
            servers = {
                "lua_ls",
                "bashls",
                "clangd",
                "dockerls",
                "rust_analyzer",
            },
            excluded_servers = {
                "glsls",
                "ltex",
                "jedi_language_server",
                "basedpyright",
                "pylyzer",
                "pylsp",
                "ruff",
                "tailwindcss",
            },
            prefer_local = true,
            vim.lsp.config("*",{
                dockerls = {
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
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {"vim"},
                            },
                        },
                    },
                },
                pyright = {
                    settings = {
                        python = {
                            analyst = {
                                typeCheckingMode = "basic",
                                reportMissingImports = true,
                                diagnosticMode = "workspace"
                            }
                        }
                    }
                },
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = true,
                            },
                            diagnostics = {
                                enable = true,
                                disabled = {},
                                enableExperimental = true,
                            },
                            checkOnSave = {
                                command = "clippy",
                            },
                            diagnosticMode = "openFiles"
                        },
                    }
                }
            })
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
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
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
            current_line_blame = true
        })
    end
},
{
    "linux-cultist/venv-selector.nvim",
    dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    ft = "python",
    keys = {
    { ",v", "<cmd>VenvSelect<cr>" },
    },
    ---@type venv-selector.Config
    opts = {
        search = {
            cwd = {
              command = "fd '/bin/python$' ~/ook/programming/ --full-path --color never -E /proc -I -a -L",
            },
        },
    },
},
{
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'qwertyuiopasdfghjklzxcvbnm'
    }
},
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
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
        enabled = true,
        debounce_delay = 100,
    }
},
{
    'voldikss/vim-floaterm'
},
{
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
            python = { "isort", "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            css = {"prettier"},
            html = {"prettier"},
            },
        })
        vim.api.nvim_create_user_command("Format", function()
          require("conform").format({
            async = true,
            lsp_fallback = true,
          })
        end, {})
    end
},

})
vim.cmd.colorscheme("catppuccin")

vim.diagnostic.config({
    virtual_lines = {
        current_line = true
    },
    -- virtual_text = true -- single line error
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end
})

vim.api.nvim_set_hl(0, "TabLineSeparatorSel", { fg = "#89b4fb", bg = "none" }) -- 

local lazierPath = vim.fn.stdpath("data") .. "/lazier/lazier.nvim"
if not (vim.uv or vim.loop).fs_stat(lazierPath) then
    local repo = "https://github.com/jake-stewart/lazier.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--branch=stable-v2", repo, lazierPath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{
            "Failed to clone lazier.nvim:\n" .. out, "Error"
        }}, true, {})
    end
end
vim.opt.runtimepath:prepend(lazierPath)
