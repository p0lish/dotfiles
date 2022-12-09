local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

return require('packer').startup(function(use)
  	use 'wbthomason/packer.nvim' -- Package manager
	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use "EdenEast/nightfox.nvim" -- Nightfox theme
	use 'nanozuki/tabby.nvim' -- Tabby tab manager
	use 'feline-nvim/feline.nvim' -- Feline statusbar
	use 'nvim-tree/nvim-web-devicons' -- icons for feline
	use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'nvim-telescope/telescope-media-files.nvim'
	use {
  	'nvim-treesitter/nvim-treesitter',
  	run = ':TSUpdate'
  }
  	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  	use "hrsh7th/nvim-cmp" -- The completion plugin
  	use "hrsh7th/cmp-buffer" -- buffer completions
  	use "hrsh7th/cmp-path" -- path completions
  	use "hrsh7th/cmp-cmdline" -- cmdline completions
  	use "saadparwaiz1/cmp_luasnip" -- snippet completions
  	use "hrsh7th/cmp-nvim-lsp"
  	use "hrsh7th/cmp-nvim-lua"
  	use "lewis6991/impatient.nvim"
  	use "L3MON4D3/LuaSnip" --snippet engine
  	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  	use "williamboman/mason.nvim" -- simple to use language server installer
  	use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
		use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
end)
