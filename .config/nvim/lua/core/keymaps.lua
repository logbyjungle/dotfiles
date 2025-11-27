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
-- vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- Prevent Ctrl+Space from acting like "w"
vim.keymap.set('n', '<C-Space>', '<Nop>', opts)
vim.keymap.set('n', '<Nul>', '<Nop>', opts)

-- Buffers
-- vim.keymap.set('n', '<C-Space><Tab>', ':bnext<CR>', opts)
-- vim.keymap.set('n', '<C-Space><S-Tab>', ':bprevious<CR>', opts)
-- vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts)   -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer


vim.keymap.set('n', '<C-Space><Tab>', '<Cmd>tabnext<CR>', opts)
vim.keymap.set('n', '<C-Space><S-Tab>', '<Cmd>tabprevious<CR>', opts)


-- for i = 1, 9 do
  -- vim.keymap.set("n", "<C-Space>" .. i, function()
    -- vim.cmd("BufferGoto " .. i)
  -- end, { desc = "Go to tab" .. i })
-- end


-- Function to go to tab `n` or create tabs until it exists
local function goto_or_create_tab(n)
  local current_tabs = vim.fn.tabpagenr('$') -- total number of tabs
  if current_tabs < n then
    for _ = current_tabs, n-1 do
      vim.cmd('tabnew') -- create new tab
      require('alpha').start(true)
    end
  end
  vim.cmd(n .. 'tabnext') -- go to tab `n`
end

-- Map <C-Space> + number (1-9)
for i = 1, 9 do
  vim.keymap.set('n', '<C-Space>' .. i, function() goto_or_create_tab(i) end, { noremap = true, silent = true })
end

-- Window management
vim.keymap.set('n', '<C-Space>l', '<C-w>v<C-w>l', opts)
vim.keymap.set('n', '<C-Space>h', '<C-w>v', opts)
vim.keymap.set('n', '<C-space>k', '<C-w>s', opts)
vim.keymap.set('n', '<C-space>j', '<C-w>s<C-w>j', opts)
vim.keymap.set('n', '<C-Space><C-l>', '<C-w>v<C-w>l', opts)
vim.keymap.set('n', '<C-Space><C-h>', '<C-w>v', opts)
vim.keymap.set('n', '<C-space><C-k>', '<C-w>s', opts)
vim.keymap.set('n', '<C-space><C-j>', '<C-w>s<C-w>j', opts)

local function close_split_or_buffer()
-- vim.keymap.set('n', '<C-Space>t', function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local bufnr = vim.api.nvim_get_current_buf()
  local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })

  if #wins > 1 then
    -- More than one split: close current split
    vim.cmd('close')
  else
    -- Last split: only delete buffer if not shown elsewhere
    local buf_windows = vim.fn.win_findbuf(bufnr)
    if #buf_windows > 1 then
      -- Buffer is open in other windows: just close current window
      vim.cmd('close')
    else
      -- Buffer is only open here: delete it
      vim.cmd('bdelete!')
      if #listed_buffers == 1 then
        require('alpha').start(true)
      end
    end
  end
end

vim.keymap.set('n', '<C-Space>t', close_split_or_buffer, opts)
vim.keymap.set('n', '<C-Space><C-t>', close_split_or_buffer, opts)
vim.keymap.set('n', '<C-q>', close_split_or_buffer, opts)

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
-- vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
-- vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
-- vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     --  go to next tab
-- vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     --  go to previous tab

vim.keymap.set('n', '<F1>', '<Nop>', { noremap = true })
vim.keymap.set('i', '<F1>', '<Nop>', { noremap = true })
vim.keymap.set('v', '<F1>', '<Nop>', { noremap = true })

vim.keymap.set("n", "<A-f>", function()
  require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true })


vim.keymap.set('n','<F5>',function()
    local dir = vim.fn.expand('%:p:h')
    local run_sh = dir .. '/run.sh'

    if vim.fn.filereadable(run_sh) == 0 then
        vim.fn.system({'curl','-fsSL','-o',run_sh,'https://raw.githubusercontent.com/logbyjungle/dotfiles/main/run.sh'})
        vim.fn.system({'chmod','+x',run_sh})
    end

    -- Run if it exists
    if vim.fn.filereadable(run_sh) == 1 then
        vim.fn.jobstart({'kitty','--detach','sh','-c','cd "' .. dir .. '" && ./run.sh; read -n 1 -s -r -p "Press any key to close"'}, {detach = true})
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

vim.keymap.set("n", "<C-Space><CR>", "<cmd>FloatermToggle<CR>", { desc = "Toggle Floaterm" })
vim.keymap.set("t", "<C-Space><CR>", "<cmd>FloatermToggle<CR>", { desc = "Toggle Floaterm" })
