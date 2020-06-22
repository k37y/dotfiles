"basic
syntax enable
set number
set rnu
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamedplus

"colors
"colorscheme lucario
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

"vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'scrooloose/nerdtree'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'junegunn/fzf'
Plugin 'morhetz/gruvbox'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
call vundle#end()
filetype plugin indent on

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
set laststatus=2
set t_Co=256
set showtabline=2
set noshowmode 

"latex
map C :!xelatex % <CR><CR>
map S :!zathura $(echo % \| sed 's/tex$/pdf/') & disown <CR><CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

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
