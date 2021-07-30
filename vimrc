"=======================================================================
" Author : Diaa Mohamed Kasem
" Date   : 24 May 2012
" VIM Configuration File
"=======================================================================

let mapleader=","             " change the leader to be a comma vs slash

" Enable man pages
runtime ftplugin/man.vim
" py3file /Users/dino/vim/diaa-python/html-indent-tag-attrs.py
" function! IndentHTMLTagAttrs()
" call inputsave()
" py3 IndentHTMLTagAttrs()
" call inputrestore()
" endfunction
" au BufNewFile,BufRead,BufEnter *.html nmap <Leader>ff :call IndentHTMLTagAttrs()<cr>

" Sets extensions for files with goto file to help with js imports
augroup suffixes
  autocmd!
  let associations = [
        \["javascript", ".js,.javascript,.es,.esx,.json"],
        \["python", ".py,.pyw"]
        \]
  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END


" =============================================================================
" Refactor a variable name in python
" =============================================================================
function! Refactor()
  call inputsave()
  let @z=input("What do you want to rename '" . @z . "' to? ")
  call inputrestore()
endfunction


" =============================================================================
" Making command R that opens a new window with the output of the following command
" =============================================================================
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | silent r !<args>

inoremap jj <esc>                      " Make jj in insert mode to go to ESC

"
" Sample command W - save as root
"
" command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" command! W w !sudo tee % > /dev/null
" command! W :execute 'w !sudo tee % > /dev/null' | :edit!

" ====================================================
" Leader Assignments
" ====================================================
" For when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

nmap <leader>n :NERDTreeToggle<CR>      " Toggle NerdTree
nmap <leader>N :NERDTreeFind<CR>        " Open NerdTree

" Opem Most Recently Used :MRU  - Dont add comments afterwards
nmap <leader>m :CtrlPMRU<CR>
" nmap <leader>m :MRU<CR>
nmap <leader>p <C-R><C-P>.           " Paste from clipboard
nmap <leader>t :tabnew<CR>           " Opens a new empty tab

" Toggle the BufExplorer
nmap <leader>o :CtrlPBuffer<CR>
au BufNewFile,BufRead,BufEnter *.json nmap <leader>F :% !cat % \| json<CR> " Formats a .json file

" Align with a letter
nmap <leader>a :Align

" ALEFix  use ALE Fixers
nmap <leader>l :ALEFix<CR> :w<CR>

"nmap <leader>f :CtrlP<CR>
nmap <leader>f :CtrlPMixed<CR>
"nnoremap <leader>. :CtrlPTag<cr>

" nmap <leader>G :bprev<CR>
" nmap <leader>g :bnext<CR>

" TODO: Check why this does not work.. it should use ACK to search and find
" definition
" nmap <leader>g :ALEGoToDefinition<CR>


" ====================
" Git Commands
" ====================

nmap <leader>gL :Glog<CR>
" Dangerous
" nmap <leader>gA :!git add . --all<CR>
nmap <leader>ga :!git add %<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>ge :Gedit<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep<CR>
nmap <leader>gl :Glog --follow %<CR>
nmap <leader>gP :Gpull<CR>
nmap <leader>gp :Gpush<CR>
nmap <leader>gs :Gstatus<CR>

" ====================
" Compiling commands
" ====================

au BufNewFile,BufRead,BufEnter *.less,*.LESS     nmap <leader>c :w<CR> :silent !lessc % %:r.css <CR>                                  " Execute lessc on the current file
au BufNewFile,BufRead,BufEnter *.css,*.CSS       nmap <leader>c :w<CR> :silent !node ~/zshconfigs/scripts/css2less.js % %:r.less <CR>                                  " Execute lessc on the current file

" ==================
" linting commands
" ==================

au BufNewFile,BufRead,BufEnter *.js,*.JS         nmap <leader>L :w<CR> :R eslint --fix <C-R>%<CR>                                                               " Execute jshint on the current js file
au BufNewFile,BufRead,BufEnter *.js              nmap <leader>= :w<CR>:!fixjsstyle %<CR>

" ====================
" Debuggers commands
" ====================

au BufNewFile,BufRead,BufEnter *.js,*.coffee nmap <leader>d Odebugger; <ESC> :w <CR>                                            " Add debugger; keyword
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>d Oimport rpdb2; rpdb2.start_embedded_debugger('diaa'); <ESC> :w <CR> " Add the python line for debugging
au BufNewFile,BufRead,BufEnter *.py          nmap <leader>c setlocal buftype=py<CR> :w<CR> :R py.test -s <C-R>% --reuse-db<CR> 10<C-W>-                            " Run nosetest over the current file
" Rename all occurences after defintion
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>r zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[%v]%:s/<C-R>//<c-r>z/g<cr>`x
" Rename in block
au BufNewFile,BufRead,BufEnter *.py nmap <Leader>rb zyiw:call Refactor()<cr>mx:silent! norm <cr>[%V]%:s/<C-R>//<c-r>z/g<cr>`x

" ====================
" Execution commands
" ====================

" au BufNewFile,BufRead,BufEnter *.coffee nmap <leader>e :.!coffee <CR> " Execute coffee on the current line
au BufNewFile,BufRead,BufEnter *.py     nmap <leader>e :.!python <CR> " Execute python on the current line
au BufNewFile,BufRead,BufEnter *.js     nmap <leader>e :.!node <CR>   " Execute node on the current line
au BufNewFile,BufRead,BufEnter *.sh     nmap <leader>e :.!bash <CR>   " Execute bash on the current line
" au BufNewFile,BufRead,BufEnter *.pl     nmap <leader>e :call setline('.', system('docker run --rm -v ' . expand('%:p:h') .':/src -w /src swipl swipl -q -s ' . expand('%:t') . ' -t ''' . getline('.') . '''')) <CR><CR>    " Execute bash on the current line

" set rtp+=<your_path_here>/typescript-tools.vim/

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

" noremap <leader>= :Autoformat<CR>

" ==============
" Reload Vimrc
" ==============

au BufNewFile,BufRead,BufEnter vimrc map <silent> <leader>v :w! <CR>:source ~/.vimrc<CR>:filetype detect<CR> :!cd ~/vim/ && git commit -am 'Update Vim' & <CR> :exe ":echo 'vimrc reloaded'"<CR>
au BufNewFile,BufRead,BufEnter .vimrc map <silent> <leader>v :w! <CR>:source ~/.vimrc<CR>:filetype detect<CR> :!cd ~/vim/ && git commit -am 'Update Vim' & <CR> :exe ":echo 'vimrc reloaded'"<CR>

" ==============
" Reload buffer
" ==============

nmap <leader>re :e <CR>

" ==============
" Window shortcut
" ==============

map <silent> <leader>x <C-W>
"map <silent> <leader>X <C-W>

" ==================================
" Have Enter to go to command line
" ==================================
" Affects all plugins
noremap ; :

" ================
" Scroll faster
" ================

nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" ================
" numbers config
" ================
nnoremap <silent> <F6> :NumbersToggle<CR>
nnoremap <silent> <F7> :NumbersOnOff<CR>
nnoremap <F8> :set invpaste paste?<CR>
imap <F8> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F8>

" au! BufRead,BufEnter *.py nmap <F8> :TagbarToggle<CR>
" au! BufRead,BufEnter *.js nmap <F8>T :TagbarToggle<CR>

" Build arduino code
" nnoremap <silent> <F8> :w<CR>:silent !cd ..; ino clean; ino build; ino upload; cd -<CR>

" =========================
" Turning off highlighing
" =========================
nmap <silent> <leader>b :silent :nohlsearch<CR>

" ==========================
" Quit window on <leader>q
" ==========================
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :q<CR>

" ==========================
" Save window on <leader>w
" ==========================
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>

" =======================
" Split the same window
" =======================
nmap <silent> <leader>h :sp<CR>
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
" Bubble single & multiple lines
" ==============================
nmap <S-Up> ddkP
nmap <S-Down> ddp
vmap <S-Up> xkP`[V`]
vmap <S-Down> xp`[V`]

" ============================================
" Read visual block
" ============================================
" vmap <leader>S :AsyncRun say --voice ava --rate=220<CR>

" ============================================
" Reselect visual block after indent/outdent
" ============================================
vnoremap < <gv
vnoremap > >gv

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
" set wildmenu              " Menu completion in command mode on <Tab>
" set wildmode=full         " <Tab> cycles between all matching choices.
set history=1000          " Set the commands history to 1000
set hidden                " Better handling for the buffers
set mouse=a               " Enable mouse interactions
"set clipboard+=unnamed    " Add the unnamed register to the clipboard
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
set backupdir=~/.vim/tmp,~/.tmp,~/tmp " ,/var/tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,~/tmp " ,/var/tmp,/tmp

" ======================
" Set the status line
" ======================
" set stl=%{fugitive#statusline()}\ Buf:#%n\ [%b][0x%B]
" set statusline^=%{fnamemodify(expand('%'),':.')}
set showmode                           " Show the current mode
" set stl+=%{expand('%:~:.')}

" =================
" Folding settings
" =================
set nofoldenable      " dont fold by default
set showfulltag       " When completing by tag, show the whole tag, not just the function name
set foldmethod=indent " fold based on syntax ( indent, syntax, manual )
set foldnestmax=99    " deepest fold is 10 levels
set foldlevel=1       " this is just what i use
" set textwidth=80      " Set text width to 120 chars
set colorcolumn=80

" get rid of the silly characters in separators
set fillchars=""
set fillchars +=stl:\ ,stlnc:\
set diffopt+=iwhite                    " Add ignorance of whitespace to diff

" au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.html setl foldmethod=indent nofoldenable
" au BufNewFile,BufReadPost *.less setl foldmethod=indent nofoldenable
" au BufNewFile,BufReadPost *.scss setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.js setl foldmethod=syntax nofoldenable

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
set ch=1                               " Make command line two lines high
set nowrap                             " don't wrap text
set autoindent                         " always set autoindenting on
set smartindent                        " use smart indent if there is no indent file
set tabstop=2                          " <tab> inserts 4 spaces
set shiftwidth=2                       " but an indent level is 4 spaces wide.
set softtabstop=2                      " <BS> over an autoindent deletes both spaces.
set expandtab                          " Use spaces, not tabs, for autoindent/tab key.
set shiftround                         " rounds indent to a multiple of shiftwidth


" =============================================================================
" Using The Silver Searcher `ag` instead of grep or ack
" =============================================================================
" sudo apt install silversearcher-ag
" brew install the_silver_searcher
if executable('ag')
  " Use ag over grep or ack
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP does't need to cache
  let g:ctrl_user_caching = 0
endif

" ====================
" Reading/Writing
" ====================
set noautowrite                        " Never write a file unless I request it.
set noautowriteall                     " NEVER.
" set auto                             " Set auto read file changes
set noautoread                         " Don't automatically re-read changed files. ( use <leader>re to reload )
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
au! BufNewFile,BufRead,BufEnter *.js      setlocal filetype=javascript " shiftwidth=4 tabstop=4 softtabstop=4 " Use editor config for that
au! BufNewFile,BufRead,BufEnter *.ts      setlocal filetype=typescript
au! BufNewFile,BufRead,BufEnter *.yml     setlocal filetype=yaml
au! BufNewFile,BufRead,BufEnter *.coffee  setlocal filetype=coffee
au! BufNewFile,BufRead,BufEnter *.ino     setlocal filetype=arduino
au! BufNewFile,BufRead,BufEnter *.jade    setlocal filetype=jade
au! BufNewFile,BufRead,BufEnter *.less    setlocal filetype=css
au! BufNewFile,BufRead,BufEnter *.sass    setlocal filetype=sass
au! BufNewFile,BufRead,BufEnter *.tmpl    setlocal filetype=html

" use .editorconfig for that - do not set the edits to be hard coded
" au! FileType arduino setlocal shiftwidth=2 tabstop=2 softtabstop=2
" au! FileType css,javascript,js setlocal shiftwidth=2 tabstop=2 softtabstop=2
" au! FileType yml,yaml,htm,html,xhtml,xml,coffee,jade,sass setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ============================================================
" Auto change directory to where the opened file is opened
" ============================================================
" set autochdir
" Better than autochdir
autocmd BufEnter * silent! lcd %:p:h

" ==========================
" Python Related Actions
" ==========================
au! FileType python                     set smartindent cinwords=ifelifelseforwhilewithtryexceptfinallydefclass
" au! FileType python set omnifunc=pythoncomplete#Complete
" au! FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au! FileType python                     setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" au! BufRead,BufEnter *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au! FileType python                     set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" ================================================
" Add xptemplate global personal directory value
" ================================================
set runtimepath+=~/.vim/plugged
set runtimepath+=~/.vim/personal

" ==============
" editorconfig
" ==============
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
let g:EditorConfig_exec_path = system('which editorconfig')

" ====================================
" Yank into the system's clipboard
" ====================================
set clipboard=unnamed
set guioptions+=a

" ==========
" Encoding UTF-8
" ==========
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,latin1

let g:miniBufExplForceSyntaxEnable = 1

let g:ctrlp_working_path_mode = 'ra'

" =============================================================================
" My Bundles here: using vim-plug
" =============================================================================
call plug#begin('~/.vim/plugged')
Plug 'rking/ag.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/bash-support.vim'
Plug 'dense-analysis/ale'
Plug 'docunext/closetag.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-scripts/filetype.vim'
Plug 'heavenshell/vim-jsdoc'
"Plug 'isRuslan/vim-es6'
Plug 'jisaacks/GitGutter'
Plug 'kien/ctrlp.vim'
Plug 'ajh17/VimCompletesMe'
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/mru'
Plug 'myusuf3/numbers.vim'
Plug 'posva/vim-vue'
Plug 'rstacruz/vim-xtract'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'jacoborus/tender.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/vimagit'
Plug 'vim-scripts/yaml.vim'
Plug 'tpope/vim-fugitive'
" Plug 'tomlion/vim-solidity'
Plug 'arzg/vim-colors-xcode'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'tomasr/molokai'
Plug 'airblade/vim-rooter'
" Plug 'jceb/vim-orgmode'
" Plug 'dbakker/vim-projectroot'
Plug 'othree/yajs.vim'
Plug 'hashivim/vim-terraform'
Plug 'folke/which-key.nvim'
Plug 'frazrepo/vim-rainbow'
Plug 'nathanaelkane/vim-indent-guides'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" =============================================================================
" IndentGuides Configurations 
" =============================================================================
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_auto_colors = 0

" =============================================================================
" Ultisnips configurations
" =============================================================================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:rainbow_active = 1
let g:deoplete#enable_at_startup = 1

" =============================================================================
" Theme
" =============================================================================
syntax enable
colorscheme tender
let g:main_font = "Monofur\\ for\\ Powerline:h13"
let g:small_font = "Monofur\\ for\\ Powerline:h13"
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

" =============================================================================
" highlight the 80th column
" =============================================================================
hi ColorColumn ctermbg=8

" =============================================================================
" ALE Configurations
" =============================================================================
let g:ale_linters = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 0
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 2000
let g:ale_lint_on_text_changed = 0
" use Ctrl-k and Ctrl-j to jump up and down between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" RUST
" let g:rust_clip_command = 'pbcopy'
" let g:rustfmt_autosave = 1

" TODO try making this dynamic
" use npm bin to get the path
" let g:jsdoc_lehre_path = '/home/pi/projects/muso/MusoBackend/node_modules/.bin/lehre'

" filetype plugin indent on " enable loading indent file for filetype
" filetype plugin on

" =============================================================================
" NerdTree configurations
" =============================================================================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowBookmarks=1   " By default show bookmarks
" let NERDTreeChDirMode=2
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/vim/NERDTreeBookmarks")
" Remove pyc files from NERDTree View
let NERDTreeIgnore = ['\.pyc$']

let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }

"=============================================================================
" Airline configurations
"=============================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='molokai'
" Airline performance
let g:airline_highlighting_cache = 1
let g:airline_extensions = []

" ==========================
" Nerd Commenter
" ==========================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 0

"=============================================================================
" Macros
"=============================================================================
"
" Tip: press combination CtrlV followed by key ex.Enter.
" This will insert Enter code represented by ^M sign
"=============================================================================
" Line of equals
let @-='O=x77p'
" JS add // @flow at the start of js file
let @f='ggO// @flowxx'
" JS oadd js function documentation template
let @d=':JsDoc'
" JS convert require to import
let @i='0ceimport/=cf(from /)x0j'
" indent HTML attributes
let @w='2f"a'
let @g='*ggnf''lgfggn<CR>'
let @c='iconsole.log('
let @s='iJSON.stringify('
" convert - muso import {... }  from models; to import DB from models;
let @m='gg/models''0f{ca{modelsG?import oconst pa = models;0'
let @l='gg}}}?importoimport log from ''../../../decorators/log'';0'

