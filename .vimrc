" --- Auto-install vim-plug if not already installed --- "
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif 

" --- Plugin section --- "
call plug#begin('~/.vim/plugged')

" --- Status line --- "
Plug 'vim-airline/vim-airline'

" --- Theming --- "
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'

" --- Completion and syntax --- "

" Editing and usability
Plug 'jiangmiao/auto-pairs'

" --- Programming Languages ---
Plug 'sheerun/vim-polyglot'
"Plug 'davidhalter/jedi-vim'

" Initialize plugin system
call plug#end()


filetype plugin indent on    " required
syntax on
" gruvbox italic fix (must appear before colorscheme)
let g:gruvbox_italic = 1
" colorscheme gruvbox
" Airline powerline fonts fix
let g:airline_powerline_fonts = 1
" Airline theme
let g:airline_theme = 'gruvbox'

" User-specific Settings.

" ---Sets---
" 
set encoding=utf-8      		" UTF-8 Support
set tabstop=4                   " 4 spaces will do
set shiftwidth=4                " control indentation for >> bind
set expandtab                   " spaces instead of tabs
set autoindent                  " always set autoindenting on
set relativenumber              " relative line numbers
set number                      " hybrid numbering with both rnu and number
set hidden                      " hide buffers instead of closing them
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if all lowercase
set nobackup                    " don't need swp files
set noswapfile                  " don't need swp files
"set showmatch                   " Show matching braces when over one
set backspace=indent,eol,start  " allow backspacing everything in insert
set hlsearch                    " highlight searches
set incsearch                   " search as typing
set laststatus=2		        " for lightline.vim plugin


" Use comma as leader
let g:mapleader = ','
" make it possible to write danish letters
let g:AutoPairsShortcutFastWrap=''

" ---Re-mappings---
" 
" Ctrl-C for yanking to register, Ctrl+P to paste from clipboard
" vnoremap <C-c> "*y :let @+=@*<CR>
" map <C-p> "+P
" Easier clipboard copy-pasting
nnoremap <Leader>y "*y
vnoremap <Leader>y "*y
nnoremap <Leader>Y "*Y
vnoremap <Leader>Y "*Y
nnoremap <Leader>p "*p
vnoremap <Leader>p "*p
nnoremap <Leader>P "*P
vnoremap <Leader>P "*P

" since I constantly accidentally mess these up when going fast
command WQ wq
command Wq wq
command W w
command Q q
" w!! to write with sudo even if not opened with sudo
cmap w!! w !sudo tee >/dev/null %
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Bind to clear search
nmap <leader>/ :nohlsearch<CR>

" --- LaTeX Stuff ---
" Navigating with guides
inoremap ,<Tab> <Esc>/<++><Enter>"_c4l
vnoremap ,<Tab> <Esc>/<++><Enter>"_c4l
map ,<Tab> <Esc>/<++><Enter>"_c4l

autocmd FileType tex inoremap <F6> <Esc>:w<Enter>:!pdflatex<space>%<Enter>a
autocmd FileType tex nnoremap <F6> :w<Enter>:!pdflatex<space>%<Enter><Enter>
autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,dm \[\]<Enter><++><Esc>khi
autocmd FileType tex inoremap ,im $$<++><Esc>5hli
autocmd FileType tex inoremap ,con \rightarrow
autocmd FileType tex inoremap ,bic \leftrightarrow



" SaveAndRun scripts
let filePath = expand("%")

" Save, compile, run C programs
let outputName = filePath[0:eval(len(filePath) - 3)]
let cCmd = ".!gcc " . filePath . " -o " . outputName . " && ./" . outputName
nnoremap <silent> <F5> :call SaveAndRun("C Runner", cCmd)<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndRun("C Runner", cCmd)<CR>

" Run Python scripts
let pCmd = ".!python " . shellescape(filePath, 1)
nnoremap <silent> <F6> :call SaveAndRun("Python", pCmd)<CR>
vnoremap <silent> <F6> :<C-u>call SaveAndRun("Python", pCmd)<CR>

function! SaveAndRun(bufferName, cmd)
    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = a:bufferName
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute a:cmd

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

