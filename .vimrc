"basic
syntax enable
set number
set rnu

"colors
colorscheme lucario

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
call vundle#end()
filetype plugin indent on

"tmuxrunner
vmap <F6> : VtrAttachToPane <CR>
vmap <F7> : VtrSendLinesToRunner <CR>

"nerdtree
map <C-n> :NERDTreeToggle<CR>

"susan/vim-instant-markdown
let g:instant_markdown_autostart = 0

"powerline
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"set laststatus=2
"set t_Co=256
"set showtabline=2
"set noshowmode 
