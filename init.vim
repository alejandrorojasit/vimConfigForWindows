call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-syntastic/syntastic'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'

call plug#end()

let mapleader=" "
nmap <Leader><Leader>s <Plug>(easymotion-s2)

let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10'

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
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
         \ <SID>check_back_space() ? "\<TAB>" :
         \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
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

" COC extensions

let g:coc_global_extensions=[ 'coc-css', 'coc-cssmodules', 'coc-emmet', 'coc-eslint', 'coc-fzf-preview', 'coc-git', 'coc-html', 'coc-json', 'coc-lightbulb', 'coc-prettier', 'coc-snippets', 'coc-stylelintplus', 'coc-svg', 'coc-tsserver', 'coc-yank']

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
   if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
   elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
   else
      execute '!' . &keywordprg . " " . expand('<cword>')
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
" Apply AutoFix to roblem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
" Indent guide lines {{{
let g:indentLine_enabled = 1

" }}}

"Split behaviour {{{
set splitright
"}}}


" NERDTree {{{

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" }}}
" Nav Split Pannel {{{

" use alt+hjkl to move between split/vsplit panels
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
" FZF {{{

nnoremap <leader><leader>f :Files<CR>
let g:fzf_action = {
         \ 'ctrl-t': 'tab split',
         \ 'ctrl-s': 'split',
         \ 'ctrl-v': 'vsplit'
         \}
" }}}

"Delete search highlight{{{

map <esc> :noh<cr>

"}}}

"Syntax {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"}}}


" Colors {{{
if has('termguicolors')
   set termguicolors
endif
let g:sonokai_style = 'default'
let g:sonoskai_better_performance = 1
let g:sonokai_enable_italic = 1
let g:sonokai_cursor = 'yellow'
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:airline_theme = 'sonokai'
colorscheme sonokai
"}}} Colors
" Spaces & Tabs {{{
set tabstop=3       " number of visual spaces per TAB
set softtabstop=3   " number of spaces in tab when editing
set shiftwidth=3    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" Clipboard {{{
set clipboard=unnamed
" }}} Clipboard

" UI Config {{{
set hidden
set relativenumber           " show line number
set number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set nobackup
set noswapfile
" }}} UI Config

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
" case-sensitive otherwise
" }}} Search

"Reload Vim config
noremap <Leader><Leader><esc> :source $MYVIMRC<CR>


"VIM personal configs

"Exit from I mode to N mode

inoremap <leader><leader>q <esc>

"VIM AutoPairs/Wrap

inoremap <leader><leader>'' <esc>bi'<esc>ea'
inoremap <leader><leader>"" <esc>bi"<esc>ea"
inoremap <leader><leader>(( <esc>bi(<esc>ea)
inoremap <leader><leader>[[ <esc>bi[<esc>ea]
inoremap <leader><leader>{{ <esc>bi{<esc>ea}
inoremap <leader><leader>(i ()<esc>i
inoremap <leader><leader>{i {}<esc>i
inoremap <leader><leader>[i []<esc>i
inoremap <leader><leader><< <esc>bi<<esc>ea>
inoremap <leader><leader>>> <esc>bi<<esc>ea/>
inoremap <leader><leader>>>i <esc>viwyi<<esc>ea><esc>o<esc>pbi</<esc>ea><esc>O<tab>
inoremap <leader><leader><<i <esc>viwyi<<esc>ea><esc>pbi</<esc>ea><esc>bba

"Create React funciontal component 

inoremap <leader><leader>rfc <esc>viwyiconst <esc>A = () => { <cr><cr><tab>return ( <cr><cr><tab><tab> )<esc>o}<esc><<<<<<o<cr>export default <C-R>"

"Create a Style Sheet

inoremap <leader><leader>cstys const styles = StyleSheet.create ({<cr>});

"Create a style prop

inoremap <leader><leader>csty style={}<left>

"Create a title prop

inoremap <leader><leader>ctle title={}<left>

"Create a onPress prop

inoremap <leader><leader>conp onPress={}<left>

"Create import 
"From React
inoremap <leader><leader>impr import React from "react";<esc>4bi<space><left>
"From ReactNative
inoremap <leader><leader>imprn import {} from "react-native";<esc>7ba<space><space><left>

"Create a useState

inoremap <leader><leader>cuses const [] = useState();<esc>4ba<space><space><left>

"Create a useEffect

inoremap <leader><leader>cusee useEffect(() => { <esc>o<esc>o}<esc>o);<esc>kki<tab><tab>

"Create a arrowFunction

"Normal
inoremap <leader><leader>arrfn () =>
"With insert mode
inoremap <leader><leader>arrfni () =><esc>2ba

"CSS 

"Flex
inoremap <leader><leader>flex flex:  ,<left>
"AlignItems
inoremap <leader><leader>alng alignItems:  ,<left>
"JustifyContent
inoremap <leader><leader>jstc justifyContent:  ,<left>
"Padding
inoremap <leader><leader>pdg padding:  ,<left>
"BackgroundColor
inoremap <leader><leader>bgc bacgroundColor:  ,<left>
"FontSize
inoremap <leader><leader>fts fontSize:  ,<left>
"FlexBasis
inoremap <leader><leader>flexb flesBasis:  ,<left>
"MarginVertical
inoremap <leader><leader>mgnv marginVertical:  ,<left>t
