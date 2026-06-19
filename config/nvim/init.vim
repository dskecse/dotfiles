set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set background=dark
set termguicolors
colorscheme catppuccin

" Avoid getting an error on the :E command
command! E Explore
