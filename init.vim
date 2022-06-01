call plug#begin(stdpath('data') . '/plugged')

   Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'} 
   Plug 'p00f/nvim-ts-rainbow'  
   Plug 'neoclide/coc.nvim', {'branch' : 'release'}
   Plug 'sainnhe/sonokai'
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'
   Plug 'airblade/vim-gitgutter'
   Plug 'scrooloose/nerdtree'
   Plug 'jiangmiao/auto-pairs'
   Plug 'yggdroot/indentline'
   Plug 'easymotion/vim-easymotion'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   
   Plug 'junegunn/fzf.vim'
   Plug 'godlygeek/tabular'
   Plug 'ryanoasis/vim-devicons'
   Plug 'fatih/vim-go' , {'do' : ':GoUpdateBinaries'}

call plug#end()

"### Set Leader key{

let mapleader = " " 

"}

"### Vim Color Scheme {

if has ('termguicolors')
   set termguicolors
endif
let g:sonokai_style = 'atlantis'
let g:sonokai_better_performance = 1
let g:sonokai_enable_italic = 1
let g:sonokai_cursor = 'orange'
let g:sonokai_transparent_background = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnistic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:airline_theme = 'sonokai'
colorscheme sonokai

"}

"### Vim-TreeSitter Config{

lua <<EOF
require'nvim-treesitter.configs'.setup {

   ensure_installed = {"bash","comment","css","go","graphql","html","http","java","javascript","json","json5","lua","scheme","tsx","typescript","vim"},

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
     enable = true
     },

  rainbow = {
     enable = true,
     extended_mode = true,
     max_file_line = nil,
     }
}
EOF
"}


"### Vim-Go Config{

let g:go_term_enabled = 1
let g:go_term_reuse = 1
let g:go_def_mapping_enable = 0

nmap <leader><leader>go :wa<cr><Plug>(go-run)

"}

"### COC Config{

let g:coc_global_extensions = ['coc-json','coc-tsserver','coc-css','coc-html','coc-markdownlint','coc-highlight','coc-prettier','coc-yank','coc-diagnostic','coc-snippets']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"}


"### Fzf Config {

nnoremap <leader><leader>f :Files<cr>
let g:fzf_action = {
      \ 'ctrl-t': 'tab-split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \}

"}


"### Vim-EasyMotion{

nmap <leader><leader>s <Plug>(easymotion-s2)

"}

"### RainBow Vim Config{

let g:rainbow_active = 1

"}

"### NerdTree Config {

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI  = 1
let g:NERDTreeIgnore     = []
let g:NERDTreeStatusLine = ''

nnoremap <silent> <C-b> :NERDTreeToggle<cr>

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"}


"### Vim Configs{

set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set nocompatible     
set tabstop=3          "number of ivusla spaces per TAB
set softtabstop=3      " number of spaces in tab when editing
set shiftwidth=3       "number of spaces to use for autoindent
set expandtab          " tab are space
set autoindent         " enable autoindent
set smartindent
set copyindent         " copy indent from the previous line
set clipboard=unnamed  " Enable clipboard paste
set ignorecase         " Ignosre case when searching
set smartcase          " Ignose case if search pattern is lower case
set hlsearch           " Highlight matche
set hidden             " Enable hidden buffers in terminal mode
set relativenumber     " Enable relative numbers
set number             " Enable show numbers at side bar
set splitright         " Split behaviour to the right

hi clear CursorLine "Clear cursor line for not background

hi CursorLine gui=underline cterm=underline  

augroup CursorLine
	au!
	au BufEnter * setlocal cursorline
	au BufLeave * setlocal nocursorline
augroup END

"}

"### VIM Map keys{

map <esc> :noh<cr> 

"}

"### Reload VIM Config{

noremap <Leader><Leader><esc> :source $MYVIMRC<cr>

"}

"### Nav split pannels{

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"}

"### Abreviations {

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"}
