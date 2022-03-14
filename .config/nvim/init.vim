"basic
syntax enable
set number
set rnu
set undodir=~/.config/nvim/undodir
set undofile
set clipboard=unnamedplus
set cmdheight=1
set cursorline
set cursorcolumn
set colorcolumn=80

"colors
colorscheme gruvbox
set background=dark

"write-tools
map <F11> : setlocal nospell <CR>
map <F10> : setlocal spell spelllang=en_gb <CR>
map <F9> : LanguageToolCheck <CR>
let g:languagetool_jar='$HOME/.vim/LanguageTool-3.7/languagetool-commandline.jar'
set nocompatible
map <F8> :ThesaurusQueryReplaceCurrentWord<CR>
let g:tq_python_version = 2

"vim-plug
"filetype off
call plug#begin()
Plug 'christoomey/vim-tmux-runner'
Plug 'scrooloose/nerdtree'
"Plug 'lervag/vimtex'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'xuhdev/vim-latex-live-preview'
Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mtdl9/vim-log-highlighting'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'
call plug#end()
filetype plugin indent on

"coc
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"vim-airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

"tmuxrunner
vmap <F6> : VtrAttachToPane <CR>
vmap <F7> : VtrSendLinesToRunner <CR>

"nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"tab
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-b> :tabnew<CR>

"susan/vim-instant-markdown
let g:instant_markdown_autostart = 0

"powerline
"set laststatus=2
"set t_Co=256
"set showtabline=2
"set noshowmode 

"latex
map C :!xelatex % <CR><CR>
map S :!zathura $(echo % \| sed 's/tex$/pdf/') & disown <CR><CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsUsePythonVersion = 3

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"linefold
autocmd BufWinleave *.* mkview
autocmd BufWinEnter *.* silent loadview

"ansible
"map P :!ansible-playbook /home/linta/Public/Ansible/Ansible/hdfc.yml <CR>

"yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

"fzf
set rtp+=~/.fzf
