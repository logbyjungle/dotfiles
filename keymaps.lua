-- Set leader key
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts)   -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts)      -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts)      -- split window horizontally     
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)
-- Navigate between splits using Ctrl + Arrow Keys
vim.keymap.set('n', '<C-Up>',    '<C-w>k', opts)
vim.keymap.set('n', '<C-Down>',  '<C-w>j', opts)
vim.keymap.set('n', '<C-Left>',  '<C-w>h', opts)
vim.keymap.set('n', '<C-Right>', '<C-w>l', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab

vim.keymap.set('n', '<F1>', '<Nop>', { noremap = true })
vim.keymap.set('i', '<F1>', '<Nop>', { noremap = true })
vim.keymap.set('v', '<F1>', '<Nop>', { noremap = true })

vim.keymap.set("n", "<A-f>", function()
  require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true })

vim.keymap.set('n','<F5>',function()
    if vim.fn.filereadable(vim.fn.expand('%:p:h') .. '/run.sh') == 1 then
        vim.fn.jobstart({'kitty','--detach','sh','-c','cd "' .. vim.fn.expand('%:p:h') .. '" && ./run.sh; read -n 1 -s -r -p "Press any key to close"'}, {detach = true})
    end
end)


vim.keymap.set("n", "<C-\\>", function()
  local api = require("Comment.api")
  local count = vim.v.count1
  local start_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")

  for i = 1, count do
    api.toggle.linewise.current()
    if i < count and vim.fn.line(".") < total_lines then
      vim.cmd("normal! j")
    end
  end

  vim.cmd("normal! " .. start_line .. "G")  -- return to original line
end, { noremap = true, silent = true })


vim.keymap.set("v", "<C-\\>", function()
  local api = require("Comment.api")
  local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.locked("toggle.linewise")(vim.fn.visualmode())
end, { noremap = true, silent = true })

vim.keymap.set('n','<Tab>','>>')
vim.keymap.set('n','<S-Tab>','<<')

vim.keymap.set({'n', 'v'}, '<F3>', ':HopWord<CR>', { silent = true })
