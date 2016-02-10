"Putting line numbers on all files by default
set number
" Set syntax on
syntax on
" Indent automatically depending on filetype
filetype indent on
set autoindent
" Case insensitive search
set ic
" Higlhight search
set hls

"Configuring Solarized color-scheme
syntax enable
set background=dark
colorscheme solarized

"Setting tab size to 4 spaces
"(http://stackoverflow.com/questions/1878974/vim-how-to-redefine-tab-as-4-spaces)
" size of a hard tabstop
set tabstop=2
" size of an "indent"
set shiftwidth=2
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2
" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab

" Setting auto-change directory to directory of the current file
" Further details in (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
autocmd BufEnter * silent! lcd %:p:h

