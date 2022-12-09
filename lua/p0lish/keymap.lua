-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local km = vim.api.nvim_set_keymap

--Remap space as leader key
km("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " " vim.g.maplocalleader = " "

km("n", "<leader>e", ":Ex<CR>", opts)

-- Format file
km("n", "<leader>r", ":lua vim.lsp.buf.format()<CR>", opts)

-- Telescope
km("n", "<leader>ff", ":Telescope find_files<CR>", opts)
km("n", "<leader>fg", ":Telescope find_files<CR>", opts)
km("n", "<leader>fb", ":Telescope find_files<CR>", opts)
km("n", "<leader>fh", ":Telescope find_files<CR>", opts)

-- Resize with arrows

-- Switch tabs --
km("n", "<leader>h", ":tabp<CR>", opts)
km("n", "<leader>l", ":tabn<CR>", opts)
