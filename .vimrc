"le &path.='src/include,/usr/include/AL,'

set modifiable
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
" Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf'
Plugin 'crusoexia/vim-monokai'
Bundle 'matze/vim-move'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tmsvg/pear-tree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-markdown'
Plugin 'zivyangll/git-blame.vim'
Plugin 'peterhoeg/vim-qml'
Plugin 'lyuts/vim-rtags'
Plugin 'bfrg/vim-cpp-modern'
Plugin 'tmhedberg/SimpylFold'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'tomtom/tcomment_vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-python/python-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'herringtondarkholme/yats'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'jparise/vim-graphql'
Plugin 'dense-analysis/ale'
Plugin 'sotte/presenting.vim'

call vundle#end()            " required
filetype plugin indent on    " required

set clipboard=unnamedplus

" Sets how many lines of history VIM has to remember
set history=500

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

:imap jj <Esc>
set exrc
set secure

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

nnoremap <silent> <F4> :set tabstop=2 softtabstop=2 shiftwidth=2 <CR>

"set colorcolumn=110
"highlight ColorColumn ctermbg=darkgray

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left, show foldlevel
" set foldcolumn=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store


set number " | set relativenumber
"autocmd InsertEnter * :set norelativenumber | set number
"autocmd InsertLeave * :set relativenumber
map <silent> <leader>n :set rnu!<cr>

" enter/space without leaving normal mode
nmap <S-CR> o<Esc>
nmap <space> a<space><Esc>
nnoremap <BS> Xh

filetype indent on
syntax on
colorscheme monokai
" set termguicolors

set laststatus=2

" vim-move
let g:move_key_modifier = 'C'

map <F5> :!g++ % && ./a.out <CR>

" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" transparence
let t:is_transparent = 1
function! Toggle_transparent_background()
  if t:is_transparent == 0
    hi Normal guibg=#111111 "
	colorscheme monokai
    let t:is_transparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent = 0
  endif
endfunction
nnoremap <C-x><C-t> :call Toggle_transparent_background()<CR>

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" git blame
nnoremap <C-g> :<C-u>call gitblame#echo()<CR>

" nerdtree
map <F3> :NERDTreeToggle<CR>

" ycm
let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_goto_buffer_command='split-or-existing-window'
map <silent> <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
" map <silent> <leader>f :let g:ycm_goto_buffer_command='same-buffer' <CR> | : YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_auto_hover=''
nmap <silent> <leader>f <plug>(YCMHover)

" python highlight
let g:python_highlight_all=1

" python with virtualenv support
py3 3
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" comment single line normally, multiple in visual
map m gcc
vmap m gc

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Trigger configuration. Do not use <tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-t>"
let g:UltiSnipsJumpForwardTrigger="<S-f>"
let g:UltiSnipsJumpBackwardTrigger="<S-b>"

" git grep
command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
nnoremap <C-F> :Ggr <cword><CR>

" javascript typescript
" let g:javascript_plugin_jsdoc = 1
setlocal indentkeys+=0.
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx


" ale (linting)
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['isort', 'autopep8', 'yapf'],
            \}
let g:ale_linters = {
            \ 'python': ['flake8'],
            \}
let g:ale_fix_on_save=1
let g:ale_linters_explicit=1
nmap <silent> <leader>j <Plug>(ale_previous_wrap)
nmap <silent> <leader>k <Plug>(ale_next_wrap)

" powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" set qs to js
au BufRead,BufNewFile *.qs set filetype=javascript

" replace ctrlp with fzf
nmap <C-P> :FZF<CR>
