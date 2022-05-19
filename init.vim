set number
set relativenumber
set guifont=Dank\ Mono
set guifontwide=Dank\ Mono
set confirm
set encoding=utf8

syntax enable

" PLUGIN SETTINGS
call plug#begin('~/.config/nvim/plugged')
" lsp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-volar', {'do': 'yarn install --frozen-lockfile'}
Plug 'yaegassy/coc-volar-tools', {'do': 'yarn install --frozen-lockfile'}
Plug 'neovim/nvim-lspconfig'
Plug 'justmao945/vim-clang'
" comp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" format
Plug 'rhysd/vim-clang-format'
" finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'yuki-yano/fzf-preview.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf_bin', 'do': './install --all'}
Plug 'lambdalisue/fern.vim'
" theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'vim-jp/vimdoc-ja'
Plug 'vim-airline/vim-airline'
"" others
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'
Plug 'Shougo/vimproc.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lambdalisue/gina.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sainnhe/gruvbox-material'
Plug 'codehearts/mascara-vim'
Plug 'onsails/lspkind.nvim'
call plug#end()

" color thheme
colorscheme tokyonight

" NERDTree SETTINGS
nmap <C-f> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
hi Directory guifg=#FF0000 ctermfg=grey
hi File guifg=#FF0000 ctermfg=grey
let NERDTreeShowHidden = 1

" Esc SETTINGS
inoremap jj <Esc>

" /// Enable Netrw (default file browser)
filetype plugin on

" /// Netrw SETTINGS
let g:netwr_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 30
let g:netrw_sizestyle = "H"
let g:netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
let g:netrw_preview = 1

"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" move window
nnoremap <Return><Return> <c-w><c-w>

"" fern
nnoremap <Leader> :<C-u>Fern . -drawer -reveal=%<CR>
let g:fern#renderer = 'Hack\ Nerd\ Font'

"" C lang format
autocmd FileType c ClangFormatAutoEnable

"" coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-fzf-preview', 'coc-lists', 'coc-clangd']

"" documentation
nnoremap <silent> K       :<C-u>call <SID>show_documentation()<CR>

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> [dev]f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
  autocmd!
  autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction


"" mascara
 let g:mascara_italic = [ 'Comment', 'ErrorMsg', 'LineNr' ] " Comments, error messages, line numbers
 let g:mascara_apply_at_startup = 0

" ale
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier-standard'],
\   'css': ['prettier'],
\}
 let g:ale_fix_on_save = 1

command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>fo <cmd>Format<cr>

"=========
"vim-clang
"=========
" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

let g:clang_exec = 'clang'
let g:clang_format_exec = 'clang-format'

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '
  \ -std=c++1z 
  \ -stdlib=libc++ 
  \ -pedantic-errors
  \ '

" }}}


"" =======================
"" lua
"" =======================
"" treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "typescript",
    "tsx",
  },
  highlight = {
    enable = true,
  },
}

  vim.opt.list = true
  vim.opt.listchars:append("eol:↴")
  require("indent_blankline").setup {
  	show_end_of_line = true,
  }

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }

 require('lspkind').init({
    mode = 'symbol_text',
    preset = 'codicons',
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})

local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}
EOF

