
"=======================================================================
" Author : Diaa Mohamed Kasem
" Date   : 24 May 2012
" VIM Configuration File
"=======================================================================

let mapleader=","             " change the leader to be a comma vs slash
let NERDTreeShowBookmarks=1   " By default show bookmarks
let g:acp_enableAtStartup = 0 
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=5
" the other mode choice is 'passive'
let g:syntastic_mode_map = { 'mode': 'passive',
                          \ 'active_filetypes': ['js'],
                          \ 'passive_filetypes': ['py'] } 
let g:syntastic_auto_loc_list=1 


" let NERDTreeChDirMode=2
" " Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/vim/NERDTreeBookmarks")

" ==========================
" Refactor a variable name
" ==========================
function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction


" Making command R that opens a new window with the output of the following command
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | silent r !<args> 

" =======================
" Set working directory
" =======================
inoremap jj <esc>                      " Make jj in insert mode to go to ESC

" ====================================================
" Leader Assignments
" ====================================================
" For when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

nmap <leader>n :NERDTreeToggle<CR>   " Toggle NerdTree
nmap <leader>N :NERDTreeFind<CR>     " Open NerdTree
" Opem Most Recently Used :MRU  - Dont add comments afterwards
nmap <leader>m :CtrlPMRU<CR>
nmap <leader>p <C-R><C-P>.           " Paste from clipboard
nmap <leader>t :tabnew<CR>           " Opens a new empty tab
" Toggle the BufExplorer
nmap <leader>o :CtrlPBuffer<CR>
nmap <leader>F :% !cat % \| json<CR> " Formats a .json file
nmap <leader>a :Align 
"nmap <leader>f :CtrlP<CR>
nmap <leader>f :CtrlPMixed<CR>
nmap <leader>G :bprev<CR>
nmap <leader>g :bnext<CR>

" Locally (local to block) rename a variable
nmap <Leader>r "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[{V%:s/<C-R>//<c-r>z/g<cr>`x

" ====================
" Git Commands
" ====================

nmap <leader>gL :Glog<CR>
nmap <leader>gP :Gpull<CR>
nmap <leader>ga :!git add . --all<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Gpull<CR>
nmap <leader>gP :Gpush<CR>
nmap <leader>gs :Gstatus<CR>

" ====================
" Compiling commands
" ====================

au BufNewFile,BufRead,BufEnter *.less   nmap <leader>c :w<CR> :silent !lessc % > %:r.css <CR>                                  " Execute lessc on the current file
au BufNewFile,BufRead,BufEnter *.jade   nmap <leader>c :w<CR> :silent !jade -P % > %:r.html <CR>                                  " Execute jade on the current file
au BufNewFile,BufRead,BufEnter *.html   nmap <leader>c :w<CR> :silent !html2jade % > %:r.jade <CR>                             " Convert the html to jade
au BufNewFile,BufRead,BufEnter *.js     nmap <leader>c :w<CR> :silent !js2coffee % > %:r.coffee <CR>                           " converts js to coffeescript
au BufNewFile,BufRead,BufEnter *.coffee nmap <leader>C :w<CR> :silent !coffee -b -cm % & <CR>                                  " Execute coffe on the current file
au BufNewFile,BufRead,BufEnter *.coffee nmap <leader>c :w<CR> :silent !coffee -cm % & <CR>                                     " Execute coffe on the current file

" ==================
" linting commands
" ==================

au BufNewFile,BufRead,BufEnter *.js,*.JS          nmap <leader>l :w<CR> :JSHint<CR>     " Execute jshint on the current js file
au BufNewFile,BufRead,BufEnter *.coffee,*.COFFEE  nmap <leader>l :w<CR> :R coffeelint -f ~/zshconfigs/coffeelint_config.json --nocolor <C-R>%<CR> " Execute coffelint on the current coffe file
au BufNewFile,BufRead,BufEnter *.json,*.JSON      nmap <leader>l :w<CR> :R jsonlint <C-R>%<CR>             " Execute jsonlint on the current json file
au BufNewFile,BufRead,BufEnter *.less,*.LESS      nmap <leader>l :w<CR> :R lesslint <C-R>%<CR>             " Execute lesslint on the current lesscss file

au BufNewFile,BufRead,BufEnter *.js nmap <leader>= :w<CR>:!fixjsstyle %<CR>

" ====================
" Debuggers commands
" ====================

au BufNewFile,BufRead,BufEnter *.js,*.coffee nmap <leader>d Odebugger; <ESC> :w <CR>                                            " Add debugger; keyword
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>d Oimport rpdb2; rpdb2.start_embedded_debugger('diaa'); <ESC> :w <CR> " Add the python line for debugging
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>c :w<CR> :R nosetests -s <C-R>% <CR> 10<C-W>-                            " Run nosetest over the current file
" Rename all occurences after defintion
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>r zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[%v]%:s/<C-R>//<c-r>z/g<cr>`x
" Rename in block
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>rb zyiw:call Refactor()<cr>mx:silent! norm <cr>[%V]%:s/<C-R>//<c-r>z/g<cr>`x

" ====================
" Execution commands
" ====================
                                                                     
au BufNewFile,BufRead,BufEnter *.coffee nmap <leader>e :.!coffee <CR> " Execute coffee on the current line
au BufNewFile,BufRead,BufEnter *.py     nmap <leader>e :.!python <CR> " Execute python on the current line
au BufNewFile,BufRead,BufEnter *.js     nmap <leader>e :.!node <CR>   " Execute node on the current line
au BufNewFile,BufRead,BufEnter *.sh     nmap <leader>e :.!bash <CR>   " Execute bash on the current line


" ==============
" Beautify
" ==============
autocmd FileType javascript noremap <buffer>  <leader>; :call JsBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <leader>; :call RangeJsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <leader>; :call HtmlBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>; :call RangeHtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>; :call CSSBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>; :call RangeCSSBeautify()<cr>

" ==============
" Reload Vimrc
" ==============

au BufNewFile,BufRead,BufEnter vimrc map <silent> <leader>v :w <CR>:source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ==============
" Reload buffer
" ==============

nmap <leader>re :e <CR>

" ==============
" Window shortcut
" ==============

map <silent> <leader>x <C-W>

" ==================================
" Have Enter to go to command line
" ==================================
" Affects all plugins 
"noremap <CR> :

" ================
" Scroll faster 
" ================

nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" ================
" numbers config
" ================
nnoremap <silent> <F3> :NumbersToggle<CR>
nnoremap <silent> <F4> :NumbersOnOff<CR>
set pastetoggle=<F6>
nnoremap <silent> <F7> :w<CR>:silent !cd ..; ino clean; ino build; ino upload; cd -<CR>
au! BufRead,BufEnter *.py nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <F9> :SyntasticCheck<CR>    

" ======================================
" Make shift-insert work like in Xterm
" ======================================
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" =========================
" Turning off highlighing
" =========================
nmap <silent> <leader>b :silent :nohlsearch<CR>
" nnoremap ' `
" nnoremap ` '

" ==========================
" Quit window on <leader>q
" ==========================

nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :q<CR>

" ==========================
" Save window on <leader>w
" ==========================

nnoremap <leader>w :w<CR>
nnoremap <leader>W :w<CR>

" =======================
" Split the same window
" =======================

nmap <silent> <leader>H :sp<CR>
nmap <silent> <leader>s :vsp<CR>
nmap <silent> <leader>sb :windo set scrollbind! <CR>

" ============================================
" Maps to make handling windows a bit easier
" ============================================

noremap <silent> <C-h> <C-W><
noremap <silent> <C-k> <C-W>-
noremap <silent> <C-j> <C-W>+
noremap <silent> <C-l> <C-W>>

" ==============================
" Bubble single&multiple lines
" ==============================

nmap <S-Down> ddp
vmap <S-Up> xkP`[V`]
vmap <S-Down> xp`[V`]
vmap <S-s> !say --voice ava --rate=220<C-M>u
nmap <S-Up> ddkP

" ============================================
" Reselect visual block after indent/outdent
" ============================================

vnoremap < <gv
vnoremap > >gv

" ============================================
" Underline the current line with '=' or '-'
" ============================================

au BufRead,BufEnter vimrc nmap <silent> <leader>u= :t.\|s/./=/g\|:nohls<cr>gcc
au BufRead,BufEnter vimrc nmap <silent> <leader>u- :t.\|s/./-/g\|:nohls<cr>gcc

" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" Load pathogen with docs for all plugins
" ==========================================================

" filetype off
" call pathogen#infect()
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()

" ===============
" Basic Settings
" ===============

syntax on                 " syntax highlighing
filetype plugin indent on " enable loading indent file for filetype
set nocp                  " For Align plugin
set number                " Display line numbers
set nrformats=            " Set number formats to only decimal
set numberwidth=1         " using only 1 column (and 1 space) while possible
set background=dark       " We are using dark background in vim
set title                 " show title in console title bar
set wildmenu              " Menu completion in command mode on <Tab>
set wildmode=full         " <Tab> cycles between all matching choices.
set history=1000          " Set the commands history to 1000
set hidden                " Better handling for the buffers
set mouse=a               " Enable mouse interactions
set clipboard+=unnamed    " Add the unnamed register to the clipboard
set nocompatible          " vim>vi
set isfname-=:            " Set the filename:linenumber delimiter to be colon
set noerrorbells visualbell t_vb=
set ofu=syntaxcomplete#Complete
set cindent

" ==================
" Printing options
" ==================
set printoptions=header:0,duplex:long,paper:letter

" ==================
" Change backupdir
" ==================
set backupdir=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ======================
" Set the status line 
" ======================
set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
set showmode                           " Show the current mode

" =================
" Folding settings
" =================

set showfulltag       " When completing by tag, show the whole tag, not just the function name
set nofoldenable      " dont fold by default
set foldmethod=indent " fold based on indent
set foldnestmax=10    " deepest fold is 10 levels
set foldlevel=1       " this is just what i use
set textwidth=80      " Set text width to 120 chars
set colorcolumn=80

set fillchars = ""                     " get rid of the silly characters in separators
set fillchars +=stl:\ ,stlnc:\
set diffopt+=iwhite                    " Add ignorance of whitespace to diff

au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" ====================================
" Ignore these files when completing
" ====================================
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set completeopt=menuone,longest

" set complete=.,w,b,t                   " Same as default except that I remove the 'u' option
set pumheight=10                       " Keep a small completion window

" =======================
" Moving Around/Editing
" =======================
set cursorline                         " have a line indicate the cursor location
set nostartofline                      " Avoid moving cursor to BOL when jumping around
set virtualedit=block                  " Let cursor move past the last char in <C-v> mode
set scrolloff=8                        " Keep 8 context lines above and below the cursor
set backspace=2                        " Allow backspacing over autoindent, EOL, and BOL
set showmatch                          " Briefly jump to a paren once it's balanced
set wrapscan                           " set the search scan to wrap lines
set ch=2                               " Make command line two lines high
set nowrap                             " don't wrap text
set autoindent                         " always set autoindenting on
set smartindent                        " use smart indent if there is no indent file
set tabstop=4                          " <tab> inserts 4 spaces 
set shiftwidth=4                       " but an indent level is 4 spaces wide.
set softtabstop=4                      " <BS> over an autoindent deletes both spaces.
set expandtab                          " Use spaces, not tabs, for autoindent/tab key.
set shiftround                         " rounds indent to a multiple of shiftwidth
set grepprg=ack

" ====================
" Reading/Writing
" ====================
set noautowrite                        " Never write a file unless I request it.
set noautowriteall                     " NEVER.
" set auto                           " Set auto read file changes
" set noautoread                         " Don't automatically re-read changed files.
set modeline                           " Allow vim options to be embedded in files;
set modelines=3                        " they must be within the first or last 5 lines.
set ffs=unix,dos,mac                   " Try recognizing dos, unix, and mac line endings.

" ===========================
" Messages, Info, Status
" ===========================
set vb t_vb=                           " Disable all bells.  I hate ringing/flashing.
set confirm                            " Y-N-C prompt if closing with unsaved changes.
set showcmd                            " Show incomplete normal mode commands as I type.
set report=0                           " : commands always print changed line count.
set shortmess+=a                       " Use [+]/[RO]/[w] for modified/readonly/written.
set laststatus=2                       " Always show statusline, even if only 1 window.

" ========================
" Searching and Patterns
" ========================
set ignorecase                         " Default to using case insensitive searches,
set smartcase                          " unless uppercase letters are used in the regex.
set smarttab                           " Handle tabs more intelligently 
set hlsearch                           " Highlight searches by default.
set incsearch                          " Incrementally search while typing a /regex

" ============================
" Set ft based on extensions
" ============================
au! BufNewFile,BufRead,BufEnter *.tmpl setlocal ft=html
au! BufNewFile,BufRead,BufEnter *.less setlocal ft=css
au! BufNewFile,BufRead,BufEnter *.coffee setlocal ft=coffee
au! BufNewFile,BufRead *.ino setlocal ft=arduino

au! FileType arduino setlocal shiftwidth=4 tabstop=4 softtabstop=4
au! FileType css,javascript,js setlocal shiftwidth=4 tabstop=4 softtabstop=4
au! FileType htm,html,xhtml,xml,coffee,jade setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ============================================================
" Auto change directory to where the opened file is opened
" ============================================================
au! BufNewFile,BufRead,BufEnter * silent! lcd %:p:h
set autochdir
au! GUIEnter * set visualbell t_vb=

" ================================================
" Use tab to scroll through autocomplete menus
" ================================================
" au VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
" au VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"

" ==========================
" Python Related Actions
" ==========================
au! BufNewFile,BufRead,BufEnter *.py set smartindent cinwords=ifelifelseforwhilewithtryexceptfinallydefclass
au! FileType python set omnifunc=pythoncomplete#Complete
au! FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au! BufRead,BufEnter *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m


" ============================================
" Don't let pyflakes use the quickfix window
" ============================================
let g:pyflakes_use_quickfix = 0
let g:acp_completeoptPreview = 1
let g:syntastic_coffeescript_checkers=['coffeelint']


" ================================================
" Add xptemplate global personal directory value
" ================================================
if has("unix")
  set runtimepath+=~/.vim/personal
endif


python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" ============
" Display
" ============
if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Inconsolata\ for\ Powerline:h15
    endif
    colorscheme Monokai
    " ===============================
    " Removing GUI Menu and Toolbar
    " ===============================
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
else
    colorscheme Monokai
endif


" ==========
" UTF 8 
" ==========
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1

let g:main_font = "Monofur\\ for\\ Powerline:h13"
let g:small_font = "Monofur\\ for\\ Powerline:h13"

" Enable 256 Colors in terminals
set t_Co=256
"set term=xterm-256color
set term=screen-256color
set runtimepath^=~/.vim/bundle/ctrlp.vim
filetype off                   " required!

" Do not use ~
" set rtp+=~/.vim/bundle/vundle/
set rtp+=/home/pi/.vim/bundle/Vundle.vim
call vundle#rc()

if has('python')
  let g:jedi#force_py_version = 2
  let g:syntastic_python_python_exec = 'python2'
  let g:pymode_python = 'python2'
elseif has('python3')
  let g:jedi#force_py_version = 3
  let g:syntastic_python_python_exec = 'python3'
  let g:pymode_python = 'python3'
else
  let g:loaded_jedi = 1
endif

autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc
let g:miniBufExplForceSyntaxEnable = 1

set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\


" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github

Plugin 'L9'
Plugin 'Raimondi/delimitMate'
Plugin 'ZoomWin'
Plugin 'bash-support.vim'
Plugin 'docunext/closetag.vim'
Plugin 'ervandew/supertab'
Plugin 'filetype.vim'
Plugin 'jshint.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kevinw/pyflakes-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'myusuf3/numbers.vim'
Plugin 'pathogen.vim'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'surround.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Align'
Plugin 'Arduino-syntax-file'
Plugin 'airblade/vim-gitgutter'
Plugin 'virtualenv.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'Syntastic'
Plugin 'pep8'
Plugin 'davidhalter/jedi-vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'
Plugin 'autoload/UltiSnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Vim-R-plugin'



filetype plugin indent on " enable loading indent file for filetype

