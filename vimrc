" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set number            " Putting line numbers on all files by default

" allow backspace over everything in insert mode
set backspace=indent,eol,start

syntax on             " Set syntax on

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		  " always set autoindenting on
endif                 " has("autocmd")

set ic                " Case insensitive search (ignore case)
set hls               " Higlhight search
set history=50	      " keep 50 lines of command line history
set ruler		          " show the cursor position all the time

" Configuring color-scheme Solarized 
" syntax enable  # testing commenting this, I think it's not needed
set background=dark
colorscheme solarized

" Setting tab size to 4 spaces
" http://stackoverflow.com/questions/1878974/vim-how-to-redefine-tab-as-4-spaces
set tabstop=2         " size of a hard tabstop
set shiftwidth=2      " size of an 'indent'
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2
" make 'tab' insert indents instead of tabs at the beginning of a line
set smarttab
set expandtab         " always uses spaces instead of tab characters

" Setting working directory to directory of the current file
" For further details see below:
" (http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file)
autocmd BufEnter * silent! lcd %:p:h

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


