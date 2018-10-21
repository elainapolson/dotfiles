" don’t bother with vi compatibility
set nocompatible

" enable syntax highlighting
syntax enable

set backspace=indent,eol,start

call plug#begin(‘~/.vim/plugged’)

Plug ‘mileszs/ack.vim’
Plug ‘christoomey/vim-tmux-navigator’
Plug ‘flazz/vim-colorschemes’
Plug ‘junegunn/fzf’, { ‘dir’: ‘~/.fzf’, ‘do’: ‘./install --bin’ }
Plug ‘junegunn/fzf.vim’
Plug ‘scrooloose/nerdtree’
Plug ‘Valloric/YouCompleteMe’
Plug ‘airblade/vim-gitgutter’
Plug ‘leafgarland/typescript-vim’
Plug ‘tpope/vim-fugitive’

call plug#end()

colorscheme solarized

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

" silver searcher
let g:ackprg = ‘ag --vimgrep’

set autoindent
set autoread                                                 ” reload files when changed on disk, i.e. via `git checkout`
set backupcopy=yes                                           ” see :help crontab
set clipboard=unnamed                                        ” yank and paste with the system clipboard
set directory-=.                                             ” don’t store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                ” expand tabs to epaces
set incsearch                                                ” search as you type
set laststatus=2                                             ” always show statusline
set list                                                     ” show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   ” show line numbers
set ruler                                                    ” show where you are
set scrolloff=3                                              ” show context above/below cursorline
set shiftwidth=2                                             ” normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                ” case-sensitive search if any caps
set softtabstop=2                                            ” insert mode tab and backspace use 2 spaces
set tabstop=8                                                ” actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 ” show a navigable menu for tab completion
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists(‘$TMUX’)  ” Support resizing in tmux
  set ttymouse=xterm2
endif

" keyboard shortcuts
let mapleader = ‘,’
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>F :NERDTreeFind<CR>
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe “:echo ‘vimrc reloaded’“<CR>
inoremap jk <ESC>

" Open fzf Files
map <leader>f :Files<CR>
map <leader>d :GFiles?<CR>
map <leader>g :GFiles<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>a :Ack!<Space>

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell

" autosave
"au FocusLost * :wa
"au FocusLost * silent! wa

" save on buffer switch
set autowrite

" Strip trailing whitespace EXCEPT for markdown files
fun! StripTrailingWhitespace()
    ” Only strip if the b:noStripeWhitespace variable isn’t set
    if exists(‘b:noStripWhitespace’)
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Rg call fzf#vim#grep(’rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --glob “!.git/*” --color “always” ’.shellescape(<q-args>), 1, <bang>0)

" Don’t copy the contents of an overwritten selection.
vnoremap p “_dP
