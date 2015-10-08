syntax on
colorscheme desert

set tabpagemax=25
set mouse=a
set wildmenu
set wildmode=list:longest,full
set autoindent

" Turn off gVim toolbar
set guioptions-=T

" http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Use Ctrl-right and Ctrl-left for next and previous tab
map <C-T>     :tabnew<CR>
map <C-Right> :tabnext<CR>
map <C-Left>  :tabprevious<CR>

" Comment Blocks of Text with vim
" http://it.toolbox.com/wiki/index.php/Comment_Blocks_of_Text_with_vim
" Highlight the block of code you want to comment, hit , then # for perl
" comments or / for // style comments or < for HTML comments

" ,# perl # comments
map ,# :s/^/# /<CR>
map ,,# :s/^# //<CR>

" ,/ C/C++/C#/Java // comments
map ,/ :s/^/\/\/ /<CR>
map ,,/ :s/^\/\/ //<CR>

" ,< HTML comment
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>
map ,,< :s/^<!-- \(.*\) -->$/\1/<CR><Esc>:nohlsearch<CR>

" C style comments
map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>

" map <M-c> :s/^/# /<CR>
" map <M-x> :s/^# //<CR>
