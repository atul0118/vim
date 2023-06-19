
" ------------------------------- PLUGINS -------------------------------------"

call plug#begin("~/.vim/plugged")

    Plug 'vim-airline/vim-airline'
    "Plug 'vim-scripts/AutoComplPop'
    Plug 'jiangmiao/auto-pairs'
    Plug 'w0rp/ale'
    Plug 'junegunn/fzf', {'do':{ -> fzf#install() }}
    Plug 'junegunn/fzf.vim'
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', { 'as': 'dracula' }

    Plug 'machakann/vim-highlightedyank'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'sainnhe/gruvbox-material'
"Plug 'morhetz/gruvbox'
"Plug 'ervandew/supertab'
"Plug 'valloric/youcompleteme'
call plug#end()
" ---------------------------------------------------------------------------------- "

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set number
set incsearch
set splitright
set scrolloff=8

let g:highlightedyank_highlight_duration = 100        "For machakann/vim-highlightedyank plugin. This is duration of highlight
set bg=dark
set termguicolors
"colorscheme gruvbox
"colorscheme gravity
colorscheme dracula
highlight cursorline cterm=none

" Making the terminal/screen background as black for better contrast
highlight Normal guibg=black

" settings for using mouse "
set mouse=a
nnoremap <2-LeftMouse> :exe "match Search /". expand("<cword>")."/"<CR>
imap <2-LeftMouse> <ESC>:exe "match Search /". expand("<cword>")."/"<CR>i

" Highlight trailing and leading whitespaces
match ErrorMsg /\s\+$/

" Settings for AutoComplPop
"inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"
set shortmess+=c

"For coding in C"
setlocal cindent
set smartindent

"----------------------  highlight current line ------------------------"
"set cursorline
"highlight CursorLine cterm=bold ctermbg=Grey ctermfg=None
" cterm means: colour terminal
" If I just enable cursorline it shows as underline in the current line
" So I changed CursorLine highlight group:
"  @cterm: controls font settings - bold,underline,reverse,italic,none
"  @ctermfg: controls foreground colours (0-255 or name of colors)
"  @ctermbg: controls background colours (0-255 or name of colors)
"  ---------------------------------------------------------------------"

" ------------------------------- KEY MAPPINGS -------------------------------------"

"Map the F3 key to show relative line numbers in NORMAL mode"
nmap <F3> :set relativenumber! <CR>

"Map the F3 key to show relative line numbers in INSERT mode"
imap <F3> <ESC> :set relativenumber! <CR>i


"Map F4 key to show whitespaces"
nmap <F4> :/\s\+$<CR>
imap <F4> <ESC> :/\s\+$<CR>i


" ---------------------------------------------------------------------------------- "

"timeout length changed for cscope"
set timeoutlen=3000

" Mapping leader key to <SPACE>
let mapleader = " "

map <silent> <Leader>t :botright vertical terminal<CR>
map <Leader>o :Lex<CR>
" Mapping to search all occurence of a word in a file
nnoremap <leader>f :lvim /<c-r>=expand("<cword>")<cr>/ %<cr>:lopen<cr>
nnoremap <leader>lc :lclose<cr>

" Mapping for opening files in tabs
nnoremap <leader><right> :tabnext<CR>
nnoremap <leader><left> :tabprevious<CR>

" mapping Ctrl-k to act as <Del>
inoremap <C-x> <Del>
nnoremap <C-x> <Del>

" With ctrl+> current line in INSERT mode
" With ctrl+< move to beginning of current line in INSERT mode

" --------- Automatically save and load views for using folds in vim ----"
"  Improve this to check if folds are created or not, and then only close all
"  the folds
"autocmd <silent> BufWinLeave * % foldclose
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview


" ------ Remove trailing whitespace while exiting a file ------"
"autocmd BufWritePre  silent! %s/\s\+$//

" --- ALE (asynchronous lint engine) --- "
"let g:ale_linter = { 'python':['flake8','pylint'] }

" Setting for netrw
let g:netrw_banner=0
let g:netrw_liststyle=3


" Abbrevations
" Whenever you will type below abbrevs and hit space, they will be replaced by the corresponding character
" To add new abbrevation, press CTRL-V and then enter the unicode for the symbol and press ENTER
" To prevent the replacement, press CTRL-V before hitting <SPACE>
ab tick ✓
ab ab_check ✅
ab ab_uncheck ❌
ab ab_b1 ✿
ab ab_b2 ༚
ab ab_ra ⇨
ab linux Linux

" **** Settings for coc *** "
let g:coc_disable_startup_warning = 1
" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.
set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

highlight CocSearch ctermfg=76

" TODO: Search all instances of an expression and display a quick fix window for
" that


